INSERT INTO geography.currency (currency_id, iso_currency_code, currency_name, currency_symbol)
VALUES ('g9999999-9999-9999-9999-999999999999', 'EUR', 'Euro', '€')
ON CONFLICT (iso_currency_code)
DO UPDATE SET currency_name = EXCLUDED.currency_name;