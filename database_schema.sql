-- =====================================================
-- RifaLibre - Schema de Base de Datos (Supabase)
-- =====================================================
-- Versión: 1.0
-- Fecha: Abril 2026
-- =====================================================

-- =====================================================
-- EXTENSIONES
-- =====================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- TABLAS PRINCIPALES
-- =====================================================

-- Perfiles de usuario (extiende auth.users)
CREATE TABLE profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT,
    phone TEXT,
    avatar_url TEXT,
    is_premium BOOLEAN DEFAULT false,
    subscription_type TEXT DEFAULT 'free' CHECK (subscription_type IN ('free', 'monthly', 'yearly')),
    subscription_end_date TIMESTAMP WITH TIME ZONE,
    preferred_currency TEXT DEFAULT 'USD' CHECK (preferred_currency IN ('USD', 'BS', 'USDT')),
    preferred_language TEXT DEFAULT 'es' CHECK (preferred_language IN ('es', 'en')),
    notifications_enabled BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Rifas
CREATE TABLE raffles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    creator_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    slug TEXT UNIQUE,  -- URL amigable para compartir
    title TEXT NOT NULL,
    description TEXT,
    prize_description TEXT,
    prize_image_url TEXT,
    beneficiary_image_url TEXT,
    ticket_price NUMERIC(10, 2) NOT NULL,
    currency TEXT DEFAULT 'USD' CHECK (currency IN ('USD', 'BS', 'USDT')),
    total_numbers INTEGER NOT NULL CHECK (total_numbers >= 10 AND total_numbers <= 10000),
    sold_count INTEGER DEFAULT 0,
    reserved_count INTEGER DEFAULT 0,
    draw_type TEXT NOT NULL CHECK (draw_type IN ('lottery', 'internal')),
    lottery_source TEXT,  -- 'triple_zulia', 'chance', 'tinka', 'other'
    draw_date TIMESTAMP WITH TIME ZONE,
    lottery_result TEXT,  -- Resultado de la lotería (últimos dígitos)
    winner_ticket_id UUID,
    status TEXT DEFAULT 'open' CHECK (status IN ('open', 'closed', 'drawn', 'cancelled')),
    whatsapp_phone TEXT,  -- Teléfono del organizador para WhatsApp
    show_ads BOOLEAN DEFAULT true,
    is_featured BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tickets/Números de la rifa
CREATE TABLE tickets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    raffle_id UUID REFERENCES raffles(id) ON DELETE CASCADE,
    number INTEGER NOT NULL,
    buyer_name TEXT,
    buyer_phone TEXT,
    buyer_email TEXT,
    buyer_whatsapp TEXT,
    status TEXT DEFAULT 'available' CHECK (status IN ('available', 'reserved', 'sold', 'blocked')),
    payment_status TEXT DEFAULT 'pending' CHECK (payment_status IN ('pending', 'approved', 'rejected')),
    payment_method TEXT,  -- 'pagomovil', 'zelle', 'binance', 'cash'
    payment_proof_url TEXT,
    payment_reference TEXT,
    payment_amount NUMERIC(10, 2),
    payment_date TIMESTAMP WITH TIME ZONE,
    rejection_reason TEXT,
    reserved_at TIMESTAMP WITH TIME ZONE,
    sold_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(raffle_id, number)
);

-- Métodos de pago del organizador
CREATE TABLE payment_methods (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    type TEXT NOT NULL CHECK (type IN ('pagomovil', 'zelle', 'binance', 'cash')),
    name TEXT NOT NULL,
    bank_name TEXT,
    account_holder TEXT,
    account_number TEXT,
    phone TEXT,
    email TEXT,
    wallet_address TEXT,
    qr_code_url TEXT,
    instructions TEXT,
    is_active BOOLEAN DEFAULT true,
    is_default BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Suscripciones premium
CREATE TABLE subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    plan_type TEXT NOT NULL CHECK (plan_type IN ('monthly', 'yearly')),
    amount NUMERIC(10, 2) NOT NULL,
    currency TEXT DEFAULT 'USD',
    payment_method TEXT,
    payment_reference TEXT,
    payment_proof_url TEXT,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'active', 'cancelled', 'expired')),
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE NOT NULL,
    auto_renew BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Stories generados para redes sociales
CREATE TABLE generated_stories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    raffle_id UUID REFERENCES raffles(id) ON DELETE CASCADE,
    image_url TEXT,
    trigger_type TEXT CHECK (trigger_type IN ('manual', 'sale', 'milestone_25', 'milestone_50', 'milestone_75', 'milestone_100')),
    milestone_percentage INTEGER,
    tickets_sold_at_generation INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

---notificaciones
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    type TEXT NOT NULL CHECK (type IN ('sale', 'payment_approved', 'payment_rejected', 'draw_result', 'milestone', 'system')),
    title TEXT NOT NULL,
    body TEXT,
    data JSONB,
    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Configuración de notificaciones por usuario
CREATE TABLE notification_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID UNIQUE REFERENCES profiles(id) ON DELETE CASCADE,
    notify_new_sale BOOLEAN DEFAULT true,
    notify_payment_approved BOOLEAN DEFAULT true,
    notify_payment_rejected BOOLEAN DEFAULT true,
    notify_draw_result BOOLEAN DEFAULT true,
    notify_milestone BOOLEAN DEFAULT true,
    notify_weekly_summary BOOLEAN DEFAULT false,
    notify_marketing BOOLEAN DEFAULT false,
    milestone_alerts BOOLEAN DEFAULT true,
    milestone_thresholds INTEGER[] DEFAULT ARRAY[25, 50, 75, 100],
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Publicidad (para monetización)
CREATE TABLE advertisements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    image_url TEXT NOT NULL,
    target_url TEXT,
    position TEXT NOT NULL CHECK (position IN ('webview_banner', 'app_banner', 'interstitial')),
    is_active BOOLEAN DEFAULT true,
    starts_at TIMESTAMP WITH TIME ZONE,
    ends_at TIMESTAMP WITH TIME ZONE,
    clicks_count INTEGER DEFAULT 0,
    impressions_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =====================================================
-- ÍNDICES
-- =====================================================

CREATE INDEX idx_raffles_creator ON raffles(creator_id);
CREATE INDEX idx_raffles_status ON raffles(status);
CREATE INDEX idx_raffles_slug ON raffles(slug);
CREATE INDEX idx_tickets_raffle ON tickets(raffle_id);
CREATE INDEX idx_tickets_status ON tickets(status);
CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_read ON notifications(user_id, is_read);

-- =====================================================
-- FUNCIONES Y TRIGGERS
-- =====================================================

-- Función: Contar rifas activas del usuario
CREATE OR REPLACE FUNCTION count_active_raffles(user_uuid UUID)
RETURNS INTEGER AS $$
DECLARE
    raffle_count INTEGER;
BEGIN
    SELECT COUNT(*)::INTEGER INTO raffle_count
    FROM raffles
    WHERE creator_id = user_uuid 
    AND status IN ('open', 'closed');
    RETURN raffle_count;
END;
$$ LANGUAGE plpgsql;

-- Función: Verificar si puede crear rifa
CREATE OR REPLACE FUNCTION can_create_raffle(user_uuid UUID)
RETURNS BOOLEAN AS $$
DECLARE
    is_premium BOOLEAN;
    raffle_count INTEGER;
BEGIN
    SELECT p.is_premium INTO is_premium 
    FROM profiles p 
    WHERE p.id = user_uuid;
    
    IF is_premium = true THEN
        RETURN true;
    END IF;
    
    raffle_count := count_active_raffles(user_uuid);
    RETURN raffle_count < 1;
END;
$$ LANGUAGE plpgsql;

-- Función: Generar slug amigable para URL
CREATE OR REPLACE FUNCTION generate_raffle_slug(input_title TEXT)
RETURNS TEXT AS $$
DECLARE
    base_slug TEXT;
    new_slug TEXT;
    counter INTEGER;
    exists BOOLEAN;
BEGIN
    -- Limpiar título: minúsculas, solo letras números y guiones
    base_slug := LOWER(REGEXP_REPLACE(input_title, '[^a-z0-9]+', '-', 'g'));
    -- Eliminar guiones al inicio y final
    base_slug := TRIM(BOTH '-' FROM base_slug);
    
    counter := 0;
    LOOP
        IF counter = 0 THEN
            new_slug := base_slug;
        ELSE
            new_slug := base_slug || '-' || counter;
        END IF;
        
        SELECT EXISTS(SELECT 1 FROM raffles WHERE slug = new_slug) INTO exists;
        
        IF NOT exists THEN
            RETURN new_slug;
        END IF;
        
        counter := counter + 1;
        IF counter > 100 THEN
            -- Si hay demasiados conflictos, usar UUID
            RETURN base_slug || '-' || LEFT(UUID_GENERATE_V4()::TEXT, 8);
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Función: Actualizar contador de tickets al cambiar status
CREATE OR REPLACE FUNCTION update_raffle_ticket_counts()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        UPDATE raffles r
        SET 
            sold_count = (
                SELECT COUNT(*)::INTEGER 
                FROM tickets 
                WHERE raffle_id = r.id AND status = 'sold'
            ),
            reserved_count = (
                SELECT COUNT(*)::INTEGER 
                FROM tickets 
                WHERE raffle_id = r.id AND status = 'reserved'
            ),
            updated_at = NOW()
        WHERE r.id = COALESCE(NEW.raffle_id, OLD.raffle_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para actualizar contadores
CREATE TRIGGER ticket_status_changed
    AFTER INSERT OR UPDATE OR DELETE ON tickets
    FOR EACH ROW
    EXECUTE FUNCTION update_raffle_ticket_counts();

-- Función: Generar tickets automáticamente al crear rifa
CREATE OR REPLACE FUNCTION create_raffle_tickets()
RETURNS TRIGGER AS $$
DECLARE
    ticket_num INTEGER;
BEGIN
    IF TG_OP = 'INSERT' AND NEW.id IS NOT NULL THEN
        FOR ticket_num IN 0..(NEW.total_numbers - 1) LOOP
            INSERT INTO tickets (raffle_id, number, status)
            VALUES (NEW.id, ticket_num, 'available');
        END LOOP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER raffle_created
    AFTER INSERT ON raffles
    FOR EACH ROW
    EXECUTE FUNCTION create_raffle_tickets();

-- Función: Actualizar timestamp automáticamente
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers para updated_at
CREATE TRIGGER profile_updated BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER raffle_updated BEFORE UPDATE ON raffles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER ticket_updated BEFORE UPDATE ON tickets
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER payment_method_updated BEFORE UPDATE ON payment_methods
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER subscription_updated BEFORE UPDATE ON subscriptions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- =====================================================
-- POLÍTICAS RLS (Row Level Security)
-- =====================================================

-- Habilitar RLS
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE raffles ENABLE ROW LEVEL SECURITY;
ALTER TABLE tickets ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_methods ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE generated_stories ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE notification_settings ENABLE ROW LEVEL SECURITY;

-- Políticas para profiles
CREATE POLICY "Users can view own profile" ON profiles
    FOR SELECT USING (user_id = auth.uid());

CREATE POLICY "Users can update own profile" ON profiles
    FOR UPDATE USING (user_id = auth.uid());

-- Políticas para raffles
CREATE POLICY "Organizers can view own raffles" ON raffles
    FOR SELECT USING (creator_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Organizers can create raffles" ON raffles
    FOR INSERT WITH CHECK (creator_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Organizers can update own raffles" ON raffles
    FOR UPDATE USING (creator_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Organizers can delete own raffles" ON raffles
    FOR DELETE USING (creator_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Política pública para ver rifas (WebView comprador)
CREATE POLICY "Anyone can view open raffles" ON raffles
    FOR SELECT USING (status = 'open');

-- Políticas para tickets
CREATE POLICY "Organizers can view own raffle tickets" ON tickets
    FOR SELECT USING (
        raffle_id IN (
            SELECT id FROM raffles 
            WHERE creator_id IN (SELECT id FROM profiles WHERE user_id = auth.uid())
        )
    );

CREATE POLICY "Organizers can update own raffle tickets" ON tickets
    FOR UPDATE USING (
        raffle_id IN (
            SELECT id FROM raffles 
            WHERE creator_id IN (SELECT id FROM profiles WHERE user_id = auth.uid())
        )
    );

-- Políticas para payment_methods
CREATE POLICY "Users can view own payment methods" ON payment_methods
    FOR SELECT USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can manage own payment methods" ON payment_methods
    FOR ALL USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Políticas para notifications
CREATE POLICY "Users can view own notifications" ON notifications
    FOR SELECT USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can update own notifications" ON notifications
    FOR UPDATE USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Políticas para notification_settings
CREATE POLICY "Users can manage own notification settings" ON notification_settings
    FOR ALL USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Políticas para subscriptions
CREATE POLICY "Users can view own subscriptions" ON subscriptions
    FOR SELECT USING (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

CREATE POLICY "Users can create subscriptions" ON subscriptions
    FOR INSERT WITH CHECK (user_id IN (SELECT id FROM profiles WHERE user_id = auth.uid()));

-- Políticas para generated_stories
CREATE POLICY "Organizers can view own stories" ON generated_stories
    FOR SELECT USING (
        raffle_id IN (
            SELECT id FROM raffles 
            WHERE creator_id IN (SELECT id FROM profiles WHERE user_id = auth.uid())
        )
    );

CREATE POLICY "Organizers can create stories" ON generated_stories
    FOR INSERT WITH CHECK (
        raffle_id IN (
            SELECT id FROM raffles 
            WHERE creator_id IN (SELECT id FROM profiles WHERE user_id = auth.uid())
        )
    );

-- =====================================================
-- DATOS INICIALES
-- =====================================================

-- Insertar advertisement de ejemplo (para testing)
INSERT INTO advertisements (title, description, image_url, position, is_active)
VALUES 
    ('RifaLibre Premium', 'Obtén rifas ilimitadas sin anuncios', 'https://via.placeholder.com/320x100', 'webview_banner', true),
    ('RifaLibre Pro', 'Gestiona tus rifas como un profesional', 'app_banner', true)
ON CONFLICT DO NOTHING;

-- =====================================================
-- FUNCIONES ADICIONALES
-- =====================================================

-- Función: Obtener rifa por slug (para URL pública)
CREATE OR REPLACE FUNCTION get_raffle_by_slug(slug_text TEXT)
RETURNS TABLE (
    id UUID,
    title TEXT,
    description TEXT,
    prize_description TEXT,
    prize_image_url TEXT,
    ticket_price NUMERIC,
    currency TEXT,
    total_numbers INTEGER,
    sold_count INTEGER,
    reserved_count INTEGER,
    draw_type TEXT,
    whatsapp_phone TEXT,
    status TEXT,
    created_at TIMESTAMP WITH TIME ZONE
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        r.id, r.title, r.description, r.prize_description, r.prize_image_url,
        r.ticket_price, r.currency, r.total_numbers, r.sold_count, r.reserved_count,
        r.draw_type, r.whatsapp_phone, r.status, r.created_at
    FROM raffles r
    WHERE r.slug = slug_text AND r.status = 'open';
END;
$$ LANGUAGE plpgsql;

-- Función: Obtener tickets disponibles de una rifa
CREATE OR REPLACE FUNCTION get_available_tickets(raffle_uuid UUID)
RETURNS TABLE (number INTEGER) AS $$
BEGIN
    RETURN QUERY
    SELECT t.number
    FROM tickets t
    WHERE t.raffle_id = raffle_uuid AND t.status = 'available'
    ORDER BY t.number;
END;
$$ LANGUAGE plpgsql;

-- Función: Obtener estadísticas del usuario
CREATE OR REPLACE FUNCTION get_user_stats(user_uuid UUID)
RETURNS TABLE (
    total_raffles INTEGER,
    active_raffles INTEGER,
    completed_raffles INTEGER,
    total_tickets_sold INTEGER,
    total_revenue NUMERIC
) AS $$
DECLARE
    profile_id UUID;
BEGIN
    SELECT id INTO profile_id FROM profiles WHERE user_id = user_uuid;
    
    IF profile_id IS NULL THEN
        RETURN;
    END IF;
    
    RETURN QUERY
    SELECT 
        COUNT(*)::INTEGER AS total_raffles,
        COUNT(*) FILTER (WHERE r.status = 'open')::INTEGER AS active_raffles,
        COUNT(*) FILTER (WHERE r.status IN ('closed', 'drawn'))::INTEGER AS completed_raffles,
        COALESCE(SUM(r.sold_count), 0)::INTEGER AS total_tickets_sold,
        COALESCE(SUM(r.ticket_price * r.sold_count), 0)::NUMERIC AS total_revenue
    FROM raffles r
    WHERE r.creator_id = profile_id;
END;
$$ LANGUAGE plpgsql;

-- Función: Obtener rifa con progreso para story
CREATE OR REPLACE FUNCTION get_raffle_progress(raffle_uuid UUID)
RETURNS TABLE (
    title TEXT,
    prize_description TEXT,
    ticket_price NUMERIC,
    currency TEXT,
    total_numbers INTEGER,
    sold_count INTEGER,
    progress_percentage NUMERIC,
    available_numbers INTEGER
) AS $$
DECLARE
    total INT;
    sold INT;
BEGIN
    SELECT r.total_numbers, r.sold_count INTO total, sold
    FROM raffles r
    WHERE r.id = raffle_uuid;
    
    RETURN QUERY
    SELECT 
        r.title,
        r.prize_description,
        r.ticket_price,
        r.currency,
        r.total_numbers,
        r.sold_count,
        CASE WHEN total > 0 THEN (sold::NUMERIC / total::NUMERIC * 100) ELSE 0 END,
        total - sold
    FROM raffles r
    WHERE r.id = raffle_uuid;
END;
$$ LANGUAGE plpgsql;