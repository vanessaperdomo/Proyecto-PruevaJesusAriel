-- ============================================================
-- DCL – Row-Level Security policies for airline_db
-- HU-006: Estrategia de roles y permisos diferenciados
-- ============================================================

-- ============================================================
-- 1. commercial.reservation
-- Un cliente solo ve sus propias reservas
-- ============================================================
ALTER TABLE commercial.reservation ENABLE ROW LEVEL SECURITY;

CREATE POLICY reservation_customer_select
    ON commercial.reservation
    FOR SELECT
    USING (
        booked_by_customer_id = current_setting('app.current_customer_id', true)::uuid
    );

-- airline_commercial puede ver y operar todas las reservas
CREATE POLICY reservation_commercial_all
    ON commercial.reservation
    FOR ALL
    TO airline_commercial
    USING (true)
    WITH CHECK (true);

-- airline_admin acceso total
CREATE POLICY reservation_admin_all
    ON commercial.reservation
    FOR ALL
    TO airline_admin
    USING (true)
    WITH CHECK (true);

-- airline_analyst / airline_auditor: solo lectura, todas las reservas
CREATE POLICY reservation_analyst_select
    ON commercial.reservation
    FOR SELECT
    TO airline_analyst, airline_auditor
    USING (true);

-- ============================================================
-- 2. commercial.sale
-- Un cliente solo ve sus propias ventas
-- ============================================================
ALTER TABLE commercial.sale ENABLE ROW LEVEL SECURITY;

CREATE POLICY sale_customer_select
    ON commercial.sale
    FOR SELECT
    USING (
        reservation_id IN (
            SELECT reservation_id FROM commercial.reservation
            WHERE booked_by_customer_id = current_setting('app.current_customer_id', true)::uuid
        )
    );

CREATE POLICY sale_commercial_all
    ON commercial.sale
    FOR ALL
    TO airline_commercial
    USING (true)
    WITH CHECK (true);

CREATE POLICY sale_finance_select
    ON commercial.sale
    FOR SELECT
    TO airline_finance
    USING (true);

CREATE POLICY sale_admin_all
    ON commercial.sale
    FOR ALL
    TO airline_admin
    USING (true)
    WITH CHECK (true);

CREATE POLICY sale_analyst_select
    ON commercial.sale
    FOR SELECT
    TO airline_analyst, airline_auditor
    USING (true);

-- ============================================================
-- 3. payment.payment
-- Solo finance y admin pueden ver todos los pagos
-- Un cliente solo ve sus propios pagos
-- ============================================================
ALTER TABLE payment.payment ENABLE ROW LEVEL SECURITY;

CREATE POLICY payment_customer_select
    ON payment.payment
    FOR SELECT
    USING (
        sale_id IN (
            SELECT s.sale_id FROM commercial.sale s
            JOIN commercial.reservation r USING (reservation_id)
            WHERE r.booked_by_customer_id = current_setting('app.current_customer_id', true)::uuid
        )
    );

CREATE POLICY payment_finance_all
    ON payment.payment
    FOR ALL
    TO airline_finance
    USING (true)
    WITH CHECK (true);

CREATE POLICY payment_admin_all
    ON payment.payment
    FOR ALL
    TO airline_admin
    USING (true)
    WITH CHECK (true);

CREATE POLICY payment_auditor_select
    ON payment.payment
    FOR SELECT
    TO airline_auditor
    USING (true);

-- ============================================================
-- 4. identity.person
-- Solo el propio usuario, admin y auditor pueden ver datos personales
-- ============================================================
ALTER TABLE identity.person ENABLE ROW LEVEL SECURITY;

CREATE POLICY person_self_select
    ON identity.person
    FOR SELECT
    USING (
        person_id = current_setting('app.current_person_id', true)::uuid
    );

CREATE POLICY person_admin_all
    ON identity.person
    FOR ALL
    TO airline_admin
    USING (true)
    WITH CHECK (true);

CREATE POLICY person_auditor_select
    ON identity.person
    FOR SELECT
    TO airline_auditor
    USING (true);

-- airline_commercial necesita leer personas para operar reservas
CREATE POLICY person_commercial_select
    ON identity.person
    FOR SELECT
    TO airline_commercial
    USING (true);

-- airline_checkin necesita leer personas para validar abordaje
CREATE POLICY person_checkin_select
    ON identity.person
    FOR SELECT
    TO airline_checkin
    USING (true);

-- ============================================================
-- 5. security.user_account
-- Solo admin y auditor pueden leer cuentas de usuario
-- ============================================================
ALTER TABLE security.user_account ENABLE ROW LEVEL SECURITY;

CREATE POLICY user_account_self_select
    ON security.user_account
    FOR SELECT
    USING (
        user_account_id = current_setting('app.current_user_id', true)::uuid
    );

CREATE POLICY user_account_admin_all
    ON security.user_account
    FOR ALL
    TO airline_admin
    USING (true)
    WITH CHECK (true);

CREATE POLICY user_account_auditor_select
    ON security.user_account
    FOR SELECT
    TO airline_auditor
    USING (true);
