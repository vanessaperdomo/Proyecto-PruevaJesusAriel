# Airline DB – PostgreSQL + Liquibase

Sistema de base de datos para aerolínea con **pgcrypto** y **Liquibase** como herramienta de migraciones.

## Estructura del proyecto

```
airline_db/
├── docker-compose.yml          # PostgreSQL 16 + Liquibase (tooling profile)
├── .env.example                # Variables de entorno
├── liquibase.properties.example
├── changelog-master.yaml       # Entrada principal de Liquibase
├── 01_ddl/                     # DDL: extensiones, schemas, tablas, índices
│   ├── 00_extensions/          → pgcrypto
│   ├── 01_schemas/             → 10 schemas (geography, identity, security, airline, ...)
│   └── 03_tables/              → 7 grupos de tablas + índices
├── 02_dml/
│   └── 00_inserts/             → Datos de referencia y catálogos
├── 03_dcl/
│   ├── 00_roles/               → 7 roles de base de datos
│   └── 01_grants/              → Permisos por rol y schema
├── 04_tcl/
│   ├── 00_transaction_blocks/  → Flujo completo de booking con SAVEPOINTs
│   └── 01_manual_recoveries/   → Recuperación manual de factura errónea
└── 05_rollbacks/               → Rollback SQL para cada changeSet
```

## Schemas

| Schema       | Dominio                                      |
|--------------|----------------------------------------------|
| `geography`  | Continentes, países, ciudades, monedas       |
| `identity`   | Personas, documentos, contactos              |
| `security`   | Usuarios, roles, permisos                    |
| `airline`    | Aerolíneas                                   |
| `airport`    | Aeropuertos, terminales, puertas, pistas      |
| `aircraft`   | Aviones, cabinas, asientos, mantenimiento    |
| `flight_ops` | Vuelos, segmentos, demoras                   |
| `commercial` | Reservas, tickets, equipaje, abordaje        |
| `loyalty`    | Programas de fidelización, millas, clientes  |
| `payment`    | Pagos, transacciones, reembolsos             |
| `billing`    | Facturas, líneas, impuestos, tipos de cambio |

## Levantamiento

```bash
# 1. Copiar variables de entorno
cp .env.example .env

# 2. Levantar PostgreSQL
docker compose up -d postgres

# 3. Ejecutar migraciones (update)
docker compose --profile tooling run --rm liquibase update

# 4. Ver estado de migraciones
docker compose --profile tooling run --rm liquibase status

# 5. Rollback último changeSet
docker compose --profile tooling run --rm liquibase rollbackCount 1

# 6. Rollback hasta un tag
docker compose --profile tooling run --rm liquibase rollback <tag>
```

## Roles de base de datos

| Rol                  | Acceso                                          |
|----------------------|-------------------------------------------------|
| `airline_admin`      | Full access a todos los schemas                 |
| `airline_ops`        | Operaciones de vuelo (airport, aircraft, flight) |
| `airline_commercial` | Reservas, tickets, fidelización                 |
| `airline_finance`    | Pagos y facturación                             |
| `airline_checkin`    | Check-in y abordaje solamente                   |
| `airline_analyst`    | Lectura en todos los schemas                    |
| `airline_auditor`    | Lectura en todos los schemas (incluye security)  |
