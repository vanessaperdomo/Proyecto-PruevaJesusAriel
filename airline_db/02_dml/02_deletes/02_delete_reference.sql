DELETE FROM security.user_status
WHERE status_code = 'INACTIVE';

DELETE FROM identity.contact_type
WHERE type_code = 'FAX';

DELETE FROM identity.document_type
WHERE type_code = 'OLD_DOC';

DELETE FROM loyalty.customer_category
WHERE category_code = 'BASIC';

DELETE FROM aircraft.maintenance_type
WHERE type_code = 'TEMP';