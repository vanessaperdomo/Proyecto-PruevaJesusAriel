-- Rollback flight operations tables (Dominio 7 - reverse FK order)
DROP TABLE IF EXISTS flight_ops.flight_delay      CASCADE;
DROP TABLE IF EXISTS flight_ops.flight_segment    CASCADE;
DROP TABLE IF EXISTS flight_ops.flight            CASCADE;
DROP TABLE IF EXISTS flight_ops.delay_reason_type CASCADE;
DROP TABLE IF EXISTS flight_ops.flight_status     CASCADE;
