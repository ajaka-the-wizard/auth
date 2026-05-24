CREATE TYPE payment_plan AS ENUM ('free','pro');

CREATE TABLE IF NOT EXISTS tenants(
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    admin UUID REFERENCES users(id) ON DELETE CASCADE,
    active BOOLEAN DEFAULT TRUE,
    plan payment_plan DEFAULT 'free',
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE tenants ENABLE ROW LEVEL SECURITY;
ALTER TABLE tenants FORCE ROW LEVEL SECURITY;

CREATE POLICY tenants_isolation ON tenants
USING (id = current_setting('app.current_id')::UUID);