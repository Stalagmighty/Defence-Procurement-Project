CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.source_record (
    id            BIGSERIAL PRIMARY KEY,
    source        TEXT        NOT NULL,
    source_key    TEXT        NOT NULL,
    payload       JSONB       NOT NULL,
    payload_hash  TEXT        NOT NULL,
    fetched_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (source, source_key, payload_hash)
);
