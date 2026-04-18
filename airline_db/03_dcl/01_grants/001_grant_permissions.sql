-- ============================================================
-- DCL – Schema & table grants per role
-- ============================================================

-- airline_admin: full access to all schemas
GRANT USAGE ON SCHEMA geography, identity, security, airline, airport, aircraft, flight_ops, commercial, loyalty, payment, billing TO airline_admin;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA geography, identity, security, airline, airport, aircraft, flight_ops, commercial, loyalty, payment, billing TO airline_admin;

-- airline_ops: flight operations read/write
GRANT USAGE ON SCHEMA geography, airport, aircraft, flight_ops TO airline_ops;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA airport, aircraft, flight_ops TO airline_ops;
GRANT SELECT ON ALL TABLES IN SCHEMA geography TO airline_ops;

-- airline_commercial: reservations, tickets, boarding
GRANT USAGE ON SCHEMA geography, identity, commercial, loyalty, airline TO airline_commercial;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA commercial, loyalty TO airline_commercial;
GRANT SELECT ON ALL TABLES IN SCHEMA geography, identity, airline TO airline_commercial;

-- airline_finance: payment and billing
GRANT USAGE ON SCHEMA payment, billing, geography TO airline_finance;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA payment, billing TO airline_finance;
GRANT SELECT ON ALL TABLES IN SCHEMA geography TO airline_finance;

-- airline_checkin: boarding and check-in only
GRANT USAGE ON SCHEMA commercial, airport, identity TO airline_checkin;
GRANT SELECT, INSERT, UPDATE ON commercial.check_in, commercial.boarding_pass, commercial.boarding_validation TO airline_checkin;
GRANT SELECT ON commercial.ticket_segment, commercial.reservation_passenger, identity.person TO airline_checkin;
GRANT SELECT ON airport.boarding_gate, airport.terminal TO airline_checkin;

-- airline_analyst: read-only all
GRANT USAGE ON SCHEMA geography, identity, security, airline, airport, aircraft, flight_ops, commercial, loyalty, payment, billing TO airline_analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA geography, identity, airline, airport, aircraft, flight_ops, commercial, loyalty, payment, billing TO airline_analyst;

-- airline_auditor: read-only all (same as analyst but explicit)
GRANT USAGE ON SCHEMA geography, identity, security, airline, airport, aircraft, flight_ops, commercial, loyalty, payment, billing TO airline_auditor;
GRANT SELECT ON ALL TABLES IN SCHEMA geography, identity, security, airline, airport, aircraft, flight_ops, commercial, loyalty, payment, billing TO airline_auditor;
