CREATE TABLE raw.source_record (
    id            BIGSERIAL PRIMARY KEY,
    source        TEXT        NOT NULL,      -- 'find_a_tender' | 'companies_house' | 'rss'
    source_key    TEXT        NOT NULL,      -- the natural id from the source
    payload       JSONB       NOT NULL,
    payload_hash  TEXT        NOT NULL,
    fetched_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (source, source_key, payload_hash)
);
