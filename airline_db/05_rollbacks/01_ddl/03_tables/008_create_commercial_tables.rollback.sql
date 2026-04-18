-- Rollback commercial tables (Dominio 8 - reverse FK order)
DROP TABLE IF EXISTS commercial.baggage               CASCADE;
DROP TABLE IF EXISTS commercial.seat_assignment       CASCADE;
DROP TABLE IF EXISTS commercial.ticket_segment        CASCADE;
DROP TABLE IF EXISTS commercial.ticket                CASCADE;
DROP TABLE IF EXISTS commercial.ticket_status         CASCADE;
DROP TABLE IF EXISTS commercial.sale                  CASCADE;
DROP TABLE IF EXISTS commercial.reservation_passenger CASCADE;
DROP TABLE IF EXISTS commercial.reservation           CASCADE;
DROP TABLE IF EXISTS commercial.fare                  CASCADE;
DROP TABLE IF EXISTS commercial.fare_class            CASCADE;
DROP TABLE IF EXISTS commercial.sale_channel          CASCADE;
DROP TABLE IF EXISTS commercial.reservation_status    CASCADE;
