-- ============================================================
-- ROLLBACK – Row-Level Security policies
-- ============================================================

-- 1. commercial.reservation
DROP POLICY IF EXISTS reservation_customer_select   ON commercial.reservation;
DROP POLICY IF EXISTS reservation_commercial_all    ON commercial.reservation;
DROP POLICY IF EXISTS reservation_admin_all         ON commercial.reservation;
DROP POLICY IF EXISTS reservation_analyst_select    ON commercial.reservation;
ALTER TABLE commercial.reservation DISABLE ROW LEVEL SECURITY;

-- 2. commercial.sale
DROP POLICY IF EXISTS sale_customer_select      ON commercial.sale;
DROP POLICY IF EXISTS sale_commercial_all       ON commercial.sale;
DROP POLICY IF EXISTS sale_finance_select       ON commercial.sale;
DROP POLICY IF EXISTS sale_admin_all            ON commercial.sale;
DROP POLICY IF EXISTS sale_analyst_select       ON commercial.sale;
ALTER TABLE commercial.sale DISABLE ROW LEVEL SECURITY;

-- 3. payment.payment
DROP POLICY IF EXISTS payment_customer_select   ON payment.payment;
DROP POLICY IF EXISTS payment_finance_all       ON payment.payment;
DROP POLICY IF EXISTS payment_admin_all         ON payment.payment;
DROP POLICY IF EXISTS payment_auditor_select    ON payment.payment;
ALTER TABLE payment.payment DISABLE ROW LEVEL SECURITY;

-- 4. identity.person
DROP POLICY IF EXISTS person_self_select        ON identity.person;
DROP POLICY IF EXISTS person_admin_all          ON identity.person;
DROP POLICY IF EXISTS person_auditor_select     ON identity.person;
DROP POLICY IF EXISTS person_commercial_select  ON identity.person;
DROP POLICY IF EXISTS person_checkin_select     ON identity.person;
ALTER TABLE identity.person DISABLE ROW LEVEL SECURITY;

-- 5. security.user_account
DROP POLICY IF EXISTS user_account_self_select  ON security.user_account;
DROP POLICY IF EXISTS user_account_admin_all    ON security.user_account;
DROP POLICY IF EXISTS user_account_auditor_select ON security.user_account;
ALTER TABLE security.user_account DISABLE ROW LEVEL SECURITY;
