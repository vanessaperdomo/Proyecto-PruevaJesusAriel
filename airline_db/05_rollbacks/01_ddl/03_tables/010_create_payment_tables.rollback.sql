-- Rollback payment tables (Dominio 10 - reverse FK order)
DROP TABLE IF EXISTS payment.refund               CASCADE;
DROP TABLE IF EXISTS payment.payment_transaction  CASCADE;
DROP TABLE IF EXISTS payment.payment              CASCADE;
DROP TABLE IF EXISTS payment.payment_method       CASCADE;
DROP TABLE IF EXISTS payment.payment_status       CASCADE;
