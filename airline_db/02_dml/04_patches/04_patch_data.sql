UPDATE identity.person
SET gender_code = 'X'
WHERE gender_code IS NULL;

UPDATE commercial.reservation
SET expires_at = booked_at + interval '1 day'
WHERE expires_at IS NULL;

UPDATE loyalty.miles_transaction
SET notes = 'AutoPatch'
WHERE notes IS NULL;

UPDATE aircraft.aircraft
SET retired_on = NULL
WHERE retired_on < in_service_on;

UPDATE billing.invoice
SET due_at = issued_at + interval '5 day'
WHERE due_at IS NULL;