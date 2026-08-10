-- INSERT TENANTS
INSERT INTO tenants (id, name) VALUES 
    ('tenant-a', 'Sunset Properties'),
    ('tenant-b', 'Ocean Rentals')
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

-- INSERT PROPERTIES
INSERT INTO properties (id, tenant_id, name, timezone) VALUES
    ('prop-001', 'tenant-a', 'Beach House Alpha', 'Europe/Paris'),
    ('prop-001', 'tenant-b', 'Mountain Lodge Beta', 'America/New_York'),
    ('prop-002', 'tenant-a', 'City Apartment Downtown', 'Europe/Paris'),
    ('prop-003', 'tenant-a', 'Country Villa Estate', 'Europe/Paris'),
    ('prop-004', 'tenant-b', 'Lakeside Cottage', 'America/New_York'),
    ('prop-005', 'tenant-b', 'Urban Loft Modern', 'America/New_York')
ON CONFLICT (id, tenant_id) DO UPDATE SET name = EXCLUDED.name, timezone = EXCLUDED.timezone;

-- INSERT RESERVATIONS

-- Sample reservation data using current month dynamically
INSERT INTO reservations (id, property_id, tenant_id, check_in_date, check_out_date, total_amount) VALUES
    ('res-tz-1', 'prop-001', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '1 day 10 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '5 days 10 hours', 1250.000),

    -- prop-001: Beach House Alpha (tenant-a)
    ('res-dec-1', 'prop-001', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '14 days 10 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '17 days 10 hours', 333.333),
    ('res-dec-2', 'prop-001', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '15 days 10 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '18 days 10 hours', 333.333),
    ('res-dec-3', 'prop-001', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '16 days 10 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '19 days 10 hours', 333.334),
    
    -- prop-002: City Apartment Downtown (tenant-a) - High-value urban property
    ('res-004', 'prop-002', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '4 days 14 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '7 days 11 hours', 1250.00),
    ('res-005', 'prop-002', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '11 days 16 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '14 days 10 hours', 1475.50),
    ('res-006', 'prop-002', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '19 days 15 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '22 days 12 hours', 1199.25),
    ('res-007', 'prop-002', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '24 days 18 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '27 days 14 hours', 1050.75),
    
    -- prop-003: Country Villa Estate (tenant-a) - Luxury property with highest rates
    ('res-008', 'prop-003', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '1 day 15 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '8 days 12 hours', 2850.00),
    ('res-009', 'prop-003', 'tenant-a', date_trunc('month', CURRENT_DATE) + INTERVAL '17 days 16 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '24 days 11 hours', 3250.50),
    
    -- prop-004: Lakeside Cottage (tenant-b) - Mid-range seasonal property  
    ('res-010', 'prop-004', 'tenant-b', date_trunc('month', CURRENT_DATE) + INTERVAL '7 days 18 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '10 days 15 hours', 420.00),
    ('res-011', 'prop-004', 'tenant-b', date_trunc('month', CURRENT_DATE) + INTERVAL '13 days 17 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '17 days 14 hours', 560.75),
    ('res-012', 'prop-004', 'tenant-b', date_trunc('month', CURRENT_DATE) + INTERVAL '21 days 16 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '25 days 13 hours', 480.25),
    ('res-013', 'prop-004', 'tenant-b', date_trunc('month', CURRENT_DATE) + INTERVAL '27 days 19 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '30 days 15 hours', 315.50),
    
    -- prop-005: Urban Loft Modern (tenant-b) - Premium downtown loft
    ('res-014', 'prop-005', 'tenant-b', date_trunc('month', CURRENT_DATE) + INTERVAL '5 days 19 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '9 days 16 hours', 920.00),
    ('res-015', 'prop-005', 'tenant-b', date_trunc('month', CURRENT_DATE) + INTERVAL '14 days 18 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '18 days 17 hours', 1080.40),
    ('res-016', 'prop-005', 'tenant-b', date_trunc('month', CURRENT_DATE) + INTERVAL '23 days 20 hours', date_trunc('month', CURRENT_DATE) + INTERVAL '28 days 14 hours', 1255.60)
ON CONFLICT (id) DO UPDATE SET 
    check_in_date = EXCLUDED.check_in_date,
    check_out_date = EXCLUDED.check_out_date,
    total_amount = EXCLUDED.total_amount;
