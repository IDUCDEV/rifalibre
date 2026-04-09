/**
 * RifaLibre - WebView del Comprador
 * Maneja la visualización y selección de números de rifa
 * 
 * @version 1.0
 * @author RifaLibre
 */

// ========================================
// CONFIGURACIÓN
// ========================================

const CONFIG = {
  // URL base de la API de Supabase
  API_URL: 'https://placeholder.supabase.co',
  API_KEY: 'placeholder-key',
  
  // URL de la app para redirigir
  APP_URL: 'https://rifalibre.app',
  
  // Tiempo de espera para requests (ms)
  TIMEOUT: 10000,
};

// ========================================
// ESTADO GLOBAL
// ========================================

const state = {
  raffle: null,
  tickets: [],
  selectedTicket: null,
  loading: true,
  error: null
};

// ========================================
// UTILIDADES
// ========================================

/**
 * Obtiene el slug de la rifa desde la URL
 */
function getSlugFromURL() {
  const path = window.location.pathname;
  // Soporta: /r/slug, /rifa/slug, o query param ?slug=xxx
  const urlParams = new URLSearchParams(window.location.search);
  
  if (urlParams.has('slug')) {
    return urlParams.get('slug');
  }
  
  const match = path.match(/\/r\/(.+)/) || path.match(/\/rifa\/(.+)/);
  return match ? match[1] : null;
}

/**
 * Formatea el precio según la moneda
 */
function formatPrice(price, currency) {
  const formatter = new Intl.NumberFormat('es-VE', {
    style: 'currency',
    currency: currency === 'USDT' ? 'USD' : currency,
    minimumFractionDigits: currency === 'BS' ? 0 : 2,
    maximumFractionDigits: currency === 'BS' ? 0 : 2
  });
  
  const symbol = currency === 'USDT' ? 'USDT ' : '';
  return symbol + formatter.format(price).replace('$', '');
}

/**
 * Muestra un toast/notification
 */
function showToast(message, type = 'info') {
  const toast = document.createElement('div');
  toast.className = `toast toast-${type}`;
  toast.textContent = message;
  document.body.appendChild(toast);
  
  setTimeout(() => {
    toast.classList.add('show');
  }, 10);
  
  setTimeout(() => {
    toast.classList.remove('show');
    setTimeout(() => toast.remove(), 300);
  }, 3000);
}

// ========================================
// API
// ========================================

/**
 * Realiza una petición a la API
 */
async function apiRequest(endpoint, options = {}) {
  const url = `${CONFIG.API_URL}${endpoint}`;
  
  const defaultOptions = {
    headers: {
      'Content-Type': 'application/json',
      'apikey': CONFIG.API_KEY,
      'Authorization': `Bearer ${CONFIG.API_KEY}`
    }
  };
  
  const finalOptions = {
    ...defaultOptions,
    ...options,
    headers: {
      ...defaultOptions.headers,
      ...options.headers
    }
  };
  
  try {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), CONFIG.TIMEOUT);
    
    const response = await fetch(url, {
      ...finalOptions,
      signal: controller.signal
    });
    
    clearTimeout(timeout);
    
    if (!response.ok) {
      throw new Error(`Error ${response.status}: ${response.statusText}`);
    }
    
    return await response.json();
  } catch (error) {
    console.error('API Error:', error);
    throw error;
  }
}

/**
 * Obtiene los datos de la rifa por slug
 */
async function fetchRaffle(slug) {
  // Si no hay API configurada, usar datos de demo
  if (CONFIG.API_URL === 'https://placeholder.supabase.co') {
    return getDemoRaffle(slug);
  }
  
  return await apiRequest(`/rest/v1/raffles?slug=eq.${slug}&select=*`);
}

/**
 * Obtiene los tickets de una rifa
 */
async function fetchTickets(raffleId) {
  // Si no hay API configurada, usar datos de demo
  if (CONFIG.API_URL === 'https://placeholder.supabase.co') {
    return getDemoTickets(raffleId);
  }
  
  return await apiRequest(`/rest/v1/tickets?raffle_id=eq.${raffleId}&select=*&order=number`);
}

// ========================================
// DATOS DE DEMO (para testing sin backend)
// ========================================

function getDemoRaffle(slug) {
  return {
    id: 'demo-raffle-001',
    slug: slug || 'demo-rifa',
    title: 'iPhone 15 Pro Max 256GB',
    description: 'El último modelo de Apple con Titanium',
    prize_description: 'iPhone 15 Pro Max 256GB - Color Natural Titanium',
    prize_image_url: null,
    ticket_price: 10,
    currency: 'USD',
    total_numbers: 100,
    sold_count: 45,
    reserved_count: 5,
    draw_type: 'internal',
    whatsapp_phone: '584123456789',
    status: 'open',
    created_at: new Date().toISOString()
  };
}

function getDemoTickets(raffleId) {
  const tickets = [];
  const soldNumbers = [5, 12, 23, 45, 67, 89, 15, 30, 50, 75];
  const reservedNumbers = [8, 25, 42];
  
  for (let i = 0; i < 100; i++) {
    let status = 'available';
    if (soldNumbers.includes(i)) status = 'sold';
    else if (reservedNumbers.includes(i)) status = 'reserved';
    
    tickets.push({
      id: `ticket-${i}`,
      number: i,
      status: status
    });
  }
  
  return tickets;
}

// ========================================
// RENDERIZADO
// ========================================

/**
 * Renderiza el contenido principal
 */
function renderContent() {
  const loading = document.getElementById('loading');
  const error = document.getElementById('error');
  const content = document.getElementById('content');
  
  if (state.loading) {
    loading.style.display = 'flex';
    error.style.display = 'none';
    content.style.display = 'none';
    return;
  }
  
  if (state.error) {
    loading.style.display = 'none';
    error.style.display = 'flex';
    content.style.display = 'none';
    return;
  }
  
  loading.style.display = 'none';
  error.style.display = 'none';
  content.style.display = 'block';
  
  // Renderizar datos de la rifa
  renderRaffleInfo();
  
  // Renderizar grid de tickets
  renderTicketGrid();
}

/**
 * Renderiza la información de la rifa
 */
function renderRaffleInfo() {
  const r = state.raffle;
  
  document.getElementById('raffleTitle').textContent = r.title;
  document.getElementById('raffleDescription').textContent = r.prize_description || '';
  
  document.getElementById('ticketPrice').textContent = formatPrice(r.ticket_price, r.currency).split(' ')[0];
  document.getElementById('ticketCurrency').textContent = r.currency;
  
  document.getElementById('soldCount').textContent = r.sold_count;
  document.getElementById('totalCount').textContent = r.total_numbers;
  
  const percent = Math.round((r.sold_count / r.total_numbers) * 100);
  document.getElementById('progressFill').style.width = `${percent}%`;
  document.getElementById('progressPercent').textContent = `${percent}% vendido`;
}

/**
 * Renderiza el grid de tickets
 */
function renderTicketGrid() {
  const grid = document.getElementById('ticketGrid');
  grid.innerHTML = '';
  
  state.tickets.forEach(ticket => {
    const el = document.createElement('div');
    el.className = `ticket ${ticket.status}`;
    el.textContent = ticket.number.toString().padStart(2, '0');
    el.dataset.number = ticket.number;
    
    if (ticket.status === 'available') {
      el.addEventListener('click', () => handleTicketClick(ticket));
    }
    
    grid.appendChild(el);
  });
}

/**
 * Maneja el click en un ticket
 */
function handleTicketClick(ticket) {
  // Deseleccionar anterior
  if (state.selectedTicket) {
    const prevEl = document.querySelector(`.ticket[data-number="${state.selectedTicket.number}"]`);
    if (prevEl) {
      prevEl.classList.remove('selected');
    }
  }
  
  // Seleccionar nuevo
  state.selectedTicket = ticket;
  
  const el = document.querySelector(`.ticket[data-number="${ticket.number}"]`);
  if (el) {
    el.classList.add('selected');
  }
  
  // Mostrar panel de selección
  renderSelectedPanel();
}

/**
 * Renderiza el panel de ticket seleccionado
 */
function renderSelectedPanel() {
  const panel = document.getElementById('selectedTicket');
  const r = state.raffle;
  const t = state.selectedTicket;
  
  document.getElementById('selectedNumber').textContent = `#${t.number.toString().padStart(2, '0')}`;
  document.getElementById('totalPrice').textContent = formatPrice(r.ticket_price, r.currency);
  
  // Generar link de WhatsApp
  const phone = r.whatsapp_phone.replace(/\D/g, ''); // Solo números
  const message = encodeURIComponent(
    `Hola! Quiero apartar el #${t.number.toString().padStart(2, '0')} de la rifa "${r.title}" (${formatPrice(r.ticket_price, r.currency)})`
  );
  const whatsappUrl = `https://wa.me/${phone}?text=${message}`;
  
  const btn = document.getElementById('whatsappBtn');
  btn.href = whatsappUrl;
  btn.target = '_blank';
  
  // Mostrar panel con animación
  panel.style.display = 'block';
  
  // Scroll suave hacia el panel
  panel.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
}

/**
 * Limpia la selección
 */
function clearSelection() {
  if (state.selectedTicket) {
    const el = document.querySelector(`.ticket[data-number="${state.selectedTicket.number}"]`);
    if (el) {
      el.classList.remove('selected');
    }
  }
  
  state.selectedTicket = null;
  document.getElementById('selectedTicket').style.display = 'none';
}

// ========================================
// INICIALIZACIÓN
// ========================================

/**
 * Inicializa la aplicación
 */
async function init() {
  console.log('RifaLibre WebView - Iniciando...');
  
  // Obtener slug de la URL
  const slug = getSlugFromURL();
  
  if (!slug) {
    state.loading = false;
    state.error = 'No se especificó ninguna rifa';
    renderContent();
    return;
  }
  
  try {
    // Cargar datos de la rifa
    const raffleData = await fetchRaffle(slug);
    
    if (!raffleData || raffleData.length === 0) {
      state.loading = false;
      state.error = 'Rifa no encontrada';
      renderContent();
      return;
    }
    
    state.raffle = Array.isArray(raffleData) ? raffleData[0] : raffleData;
    
    // Verificar que la rifa esté abierta
    if (state.raffle.status !== 'open') {
      state.loading = false;
      state.error = 'Esta rifa ya ha finalizado';
      renderContent();
      return;
    }
    
    // Cargar tickets
    const ticketsData = await fetchTickets(state.raffle.id);
    state.tickets = Array.isArray(ticketsData) ? ticketsData : [];
    
    // Actualizar contadores locales
    const sold = state.tickets.filter(t => t.status === 'sold').length;
    const reserved = state.tickets.filter(t => t.status === 'reserved').length;
    state.raffle.sold_count = sold;
    state.raffle.reserved_count = reserved;
    
    state.loading = false;
    renderContent();
    
    console.log('Rifa cargada:', state.raffle);
    console.log('Tickets:', state.tickets.length);
    
  } catch (error) {
    console.error('Error cargando rifa:', error);
    state.loading = false;
    state.error = 'Error al cargar la rifa. Intenta de nuevo.';
    renderContent();
  }
}

/**
 * Configura event listeners
 */
function setupEventListeners() {
  // Botón de limpiar selección
  document.getElementById('clearSelection').addEventListener('click', clearSelection);
  
  // Prevenir scroll en el grid
  document.getElementById('ticketGrid').addEventListener('touchmove', (e) => {
    if (e.target === e.currentTarget) {
      e.preventDefault();
    }
  }, { passive: false });
}

// ========================================
// DETECCIÓN DE MODO OFFLINE/ONLINE
// ========================================

window.addEventListener('online', () => {
  showToast('Conexión restaurada', 'success');
});

window.addEventListener('offline', () => {
  showToast('Sin conexión. Los datos pueden estar desactualizados.', 'warning');
});

// ========================================
// INICIAR APP
// ========================================

// Esperar a que el DOM esté listo
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => {
    init();
    setupEventListeners();
  });
} else {
  init();
  setupEventListeners();
}

// ========================================
// EXPORTAR PARA DEBUG
// ========================================

window.RifaLibre = {
  state,
  CONFIG,
  refresh: init,
  clearSelection
};

console.log('RifaLibre WebView cargado. Accede a window.RifaLibre para debug.');