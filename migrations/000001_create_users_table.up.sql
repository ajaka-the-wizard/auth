CREATE TYPE provider_enum AS ENUM ('google','github','custom');
-- CREATE EXTENSION IF NOT EXISTS citex SCHEMA public;

CREATE TABLE IF NOT EXISTS users(
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    email TEXT NOT NULL UNIQUE,
    provider provider_enum NOT NULL DEFAULT 'custom',
    provider_sub TEXT,
    verified BOOLEAN DEFAULT FALSE,
    active BOOLEAN DEFAULT FALSE,
    admin BOOLEAN DEFAULT FALSE,
    password TEXT,
    CONSTRAINT users_auth_mode_consistency CHECK(
        (provider = 'custom' AND password is NOT NULL AND provider_sub IS NULL)
        OR
        (provider IN ('google','github') AND provider_sub IS NOT NULL AND password IS NULL)
    ),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);