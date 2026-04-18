UPDATE geography.country
SET country_name = 'ColombiaUpdated'
WHERE country_id = 'b1111111-1111-1111-1111-111111111111';

UPDATE geography.city
SET city_name = 'NeivaUpdated'
WHERE city_id = 'd1111111-1111-1111-1111-111111111111';

UPDATE geography.currency
SET currency_name = 'PesoColombianoUpdated'
WHERE currency_id = 'g1111111-1111-1111-1111-111111111111';

UPDATE geography.state_province
SET state_name = 'HuilaUpdated'
WHERE state_province_id = 'c1111111-1111-1111-1111-111111111111';

UPDATE geography.time_zone
SET time_zone_name = 'UTC-5 Colombia Updated'
WHERE time_zone_id = '11111111-1111-1111-1111-111111111111';