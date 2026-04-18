-- Rollback boarding & check-in tables (Dominio 9 - reverse FK order)
DROP TABLE IF EXISTS commercial.boarding_validation CASCADE;
DROP TABLE IF EXISTS commercial.boarding_pass       CASCADE;
DROP TABLE IF EXISTS commercial.check_in            CASCADE;
DROP TABLE IF EXISTS commercial.check_in_status     CASCADE;
DROP TABLE IF EXISTS commercial.boarding_group      CASCADE;
