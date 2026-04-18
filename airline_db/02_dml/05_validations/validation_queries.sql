-- Validar relaciones FK
SELECT COUNT(*) FROM identity.person p
WHERE p.person_type_id IS NULL;

-- Validar duplicados
SELECT iso_currency_code, COUNT(*)
FROM geography.currency
GROUP BY iso_currency_code
HAVING COUNT(*) > 1;

-- Validar datos obligatorios
SELECT * FROM commercial.ticket
WHERE ticket_number IS NULL;

-- Validar integridad de fechas
SELECT * FROM billing.invoice
WHERE due_at < issued_at;

-- Validar dependencias
SELECT * FROM airport.airport a
LEFT JOIN geography.address ad ON a.address_id = ad.address_id
WHERE ad.address_id IS NULL;