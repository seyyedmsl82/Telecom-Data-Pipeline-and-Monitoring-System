CREATE TABLE bts_stations (
    bts_id INT PRIMARY KEY, 
    
    city VARCHAR(50) NOT NULL, 
    
    region VARCHAR(50) NOT NULL, 
    
    capacity INT NOT NULL CHECK (capacity > 0)
);


CREATE TABLE network_traffics (
    id BIGINT PRIMARY KEY, 

    bts_id INT NOT NULL, 
    
    recorded_at TIMESTAMP NOT NULL, 
    
    total_calls INT NOT NULL
        CHECK (total_calls >= 0), 
    
    failed_calls INT NOT NULL
        CHECK (failed_calls >= 0), 
    
    data_usage_mb DOUBLE PRECISION NOT NULL
        CHECK (data_usage_mb >= 0),
    
    latency_ms DOUBLE PRECISION NOT NULL 
        CHECK (latency_ms >= 0), 

    CONSTRAINT fk_bts
        FOREIGN KEY (bts_id)
        REFERENCES bts_stations(bts_id),

    CONSTRAINT valid_failed_calls
        CHECK (failed_calls <= total_calls)
);

CREATE INDEX idx_traffic_bts_time 
ON network_traffics (bts_id, recorded_at);