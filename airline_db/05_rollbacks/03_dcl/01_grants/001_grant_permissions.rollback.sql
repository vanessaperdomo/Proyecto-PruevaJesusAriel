-- Revoke all privileges granted to airline roles
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA geography   FROM airline_admin, airline_ops, airline_commercial, airline_finance, airline_checkin, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA identity    FROM airline_admin, airline_ops, airline_commercial, airline_finance, airline_checkin, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA security    FROM airline_admin, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA airline     FROM airline_admin, airline_ops, airline_commercial, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA airport     FROM airline_admin, airline_ops, airline_checkin, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA aircraft    FROM airline_admin, airline_ops, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA flight_ops  FROM airline_admin, airline_ops, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA commercial  FROM airline_admin, airline_commercial, airline_checkin, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA loyalty     FROM airline_admin, airline_commercial, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA payment     FROM airline_admin, airline_finance, airline_analyst, airline_auditor;
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA billing     FROM airline_admin, airline_finance, airline_analyst, airline_auditor;

REVOKE USAGE ON SCHEMA geography, identity, security, airline, airport, aircraft, flight_ops, commercial, loyalty, payment, billing
    FROM airline_admin, airline_ops, airline_commercial, airline_finance, airline_checkin, airline_analyst, airline_auditor;
