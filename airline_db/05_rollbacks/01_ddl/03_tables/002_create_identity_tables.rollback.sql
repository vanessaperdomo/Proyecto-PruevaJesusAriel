-- Rollback identity tables (Dominio 2 - reverse FK order)
DROP TABLE IF EXISTS identity.person_contact     CASCADE;
DROP TABLE IF EXISTS identity.person_document    CASCADE;
DROP TABLE IF EXISTS identity.person             CASCADE;
DROP TABLE IF EXISTS identity.contact_type       CASCADE;
DROP TABLE IF EXISTS identity.document_type      CASCADE;
DROP TABLE IF EXISTS identity.person_type        CASCADE;
