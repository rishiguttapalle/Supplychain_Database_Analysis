-- =====================================================
-- SUPPLY CHAIN DATABASE - FINAL DATA GENERATION SCRIPT
-- Generates realistic data for 2022-2024
-- =====================================================

-- =====================================================
-- 1. INSERT REGIONS
-- =====================================================
INSERT INTO regions (region_name, country, region_manager) VALUES
('Northeast', 'USA', 'Sarah Johnson'),
('Southeast', 'USA', 'Michael Chen'),
('Midwest', 'USA', 'Emily Rodriguez'),
('Southwest', 'USA', 'David Kim'),
('West Coast', 'USA', 'Jennifer Martinez'),
('Central Canada', 'Canada', 'Robert Thompson');

-- =====================================================
-- 2. INSERT WAREHOUSES
-- =====================================================
INSERT INTO warehouses (warehouse_name, region_id, address, city, state, zip_code, capacity_sqft, warehouse_type, operational_status) VALUES
('NYC Distribution Center', 1, '1500 Industry Ave', 'New York', 'NY', '10001', 150000, 'Distribution', 'Active'),
('Boston Fulfillment Hub', 1, '800 Harbor Way', 'Boston', 'MA', '02101', 120000, 'Fulfillment', 'Active'),
('Atlanta Regional DC', 2, '2200 Logistics Pkwy', 'Atlanta', 'GA', '30301', 180000, 'Distribution', 'Active'),
('Miami Cold Storage', 2, '450 Port Blvd', 'Miami', 'FL', '33101', 80000, 'Cold Storage', 'Active'),
('Chicago Central Hub', 3, '3500 Industrial Dr', 'Chicago', 'IL', '60601', 200000, 'Distribution', 'Active'),
('Detroit Auto Parts', 3, '900 Manufacturing St', 'Detroit', 'MI', '48201', 100000, 'Distribution', 'Active'),
('Dallas Mega Center', 4, '5000 Commerce Way', 'Dallas', 'TX', '75201', 250000, 'Distribution', 'Active'),
('Phoenix Regional', 4, '1800 Desert Rd', 'Phoenix', 'AZ', '85001', 140000, 'Fulfillment', 'Active'),
('Los Angeles Port DC', 5, '700 Harbor Fwy', 'Los Angeles', 'CA', '90001', 220000, 'Distribution', 'Active'),
('Seattle Tech Hub', 5, '1200 Tech Ave', 'Seattle', 'WA', '98101', 130000, 'Fulfillment', 'Active'),
('San Francisco Bay', 5, '950 Innovation Dr', 'San Francisco', 'CA', '94101', 110000, 'Distribution', 'Active'),
('Toronto Central', 6, '1500 King St', 'Toronto', 'ON', 'M5H2N2', 160000, 'Distribution', 'Active');

-- =====================================================
-- 3. INSERT SUPPLIERS
-- =====================================================
INSERT INTO suppliers (supplier_name, contact_person, email, phone, city, country, supplier_category, payment_terms, rating) VALUES
('TechParts Manufacturing', 'John Smith', 'john@techparts.com', '555-0101', 'Shenzhen', 'China', 'Raw Materials', 'Net 60', 4.5),
('American Steel Co', 'Mary Johnson', 'mary@amsteel.com', '555-0102', 'Pittsburgh', 'USA', 'Raw Materials', 'Net 30', 4.8),
('Global Electronics Ltd', 'Wei Zhang', 'wei@globalelec.com', '555-0103', 'Taipei', 'Taiwan', 'Finished Goods', 'Net 45', 4.2),
('Midwest Packaging Inc', 'Bob Williams', 'bob@mwpack.com', '555-0104', 'Chicago', 'USA', 'Packaging', 'Net 30', 4.7),
('European Auto Parts', 'Hans Mueller', 'hans@eureauto.com', '555-0105', 'Stuttgart', 'Germany', 'Finished Goods', 'Net 60', 4.6),
('Pacific Textiles', 'Yuki Tanaka', 'yuki@pactex.com', '555-0106', 'Tokyo', 'Japan', 'Raw Materials', 'Net 45', 4.4),
('Mexico Manufacturing', 'Carlos Rodriguez', 'carlos@mexmfg.com', '555-0107', 'Monterrey', 'Mexico', 'Finished Goods', 'Net 30', 4.3),
('Canadian Lumber Co', 'Sarah Lee', 'sarah@canlumber.com', '555-0108', 'Vancouver', 'Canada', 'Raw Materials', 'Net 30', 4.9),
('Southeast Plastics', 'Tom Brown', 'tom@seplastics.com', '555-0109', 'Atlanta', 'USA', 'Packaging', 'Net 30', 4.1),
('Nordic Tools AB', 'Erik Larsson', 'erik@nordictools.com', '555-0110', 'Stockholm', 'Sweden', 'Finished Goods', 'Net 60', 4.7);

-- =====================================================
-- 4. INSERT CARRIERS
-- =====================================================
INSERT INTO carriers (carrier_name, carrier_type, contact_email, contact_phone, service_level, base_rate, rating) VALUES
('FedEx Ground', 'Ground', 'support@fedex.com', '800-463-3339', 'Standard', 8.50, 4.6),
('FedEx Express', 'Air', 'support@fedex.com', '800-463-3339', 'Express', 25.00, 4.7),
('UPS Ground', 'Ground', 'support@ups.com', '800-742-5877', 'Standard', 8.00, 4.5),
('UPS Next Day Air', 'Air', 'support@ups.com', '800-742-5877', 'Overnight', 45.00, 4.8),
('USPS Priority', 'Ground', 'support@usps.com', '800-275-8777', 'Standard', 7.50, 4.2),
('DHL Express', 'Air', 'support@dhl.com', '800-225-5345', 'Express', 30.00, 4.4),
('XPO Logistics', 'Ground', 'support@xpo.com', '855-976-6951', 'Standard', 6.50, 4.3),
('Old Dominion Freight', 'Ground', 'support@odfl.com', '800-432-6335', 'Standard', 7.00, 4.6),
('J.B. Hunt Transport', 'Ground', 'support@jbhunt.com', '800-643-3622', 'Standard', 6.00, 4.5),
('Maersk Ocean Freight', 'Ocean', 'support@maersk.com', '800-526-7705', 'Standard', 2.50, 4.1);

-- =====================================================
-- 5. INSERT PRODUCTS (50 Products)
-- =====================================================
INSERT INTO products (product_name, sku, category, subcategory, unit_price, unit_cost, weight_lbs, dimensions, reorder_point, lead_time_days, supplier_id) VALUES
-- Electronics
('Wireless Mouse Pro', 'ELEC-M-001', 'Electronics', 'Peripherals', 29.99, 12.50, 0.5, '5x3x2', 100, 14, 3),
('Mechanical Keyboard RGB', 'ELEC-K-002', 'Electronics', 'Peripherals', 89.99, 35.00, 2.0, '18x6x2', 50, 21, 3),
('USB-C Hub 7-Port', 'ELEC-H-003', 'Electronics', 'Accessories', 49.99, 18.00, 0.8, '4x3x1', 80, 14, 3),
('Wireless Earbuds Pro', 'ELEC-E-004', 'Electronics', 'Audio', 129.99, 45.00, 0.3, '3x3x2', 150, 28, 3),
('LED Monitor 27inch', 'ELEC-MON-005', 'Electronics', 'Displays', 299.99, 120.00, 15.0, '25x16x8', 30, 35, 3),
('Laptop Stand Aluminum', 'ELEC-A-006', 'Electronics', 'Accessories', 39.99, 15.00, 2.5, '10x10x3', 60, 14, 1),
('Webcam 1080p HD', 'ELEC-W-007', 'Electronics', 'Peripherals', 79.99, 30.00, 0.6, '4x3x3', 70, 21, 3),
('Portable SSD 1TB', 'ELEC-S-008', 'Electronics', 'Storage', 149.99, 60.00, 0.4, '4x3x0.5', 100, 28, 3),
('HDMI Cable 10ft', 'ELEC-C-009', 'Electronics', 'Cables', 14.99, 4.50, 0.3, '12x8x2', 200, 7, 1),
('Power Strip 12 Outlet', 'ELEC-P-010', 'Electronics', 'Accessories', 34.99, 12.00, 2.0, '15x3x2', 90, 14, 1),
-- Automotive
('Engine Oil 5W-30 5Qt', 'AUTO-O-011', 'Automotive', 'Fluids', 24.99, 8.50, 9.0, '10x8x6', 300, 14, 5),
('Air Filter Premium', 'AUTO-F-012', 'Automotive', 'Filters', 19.99, 6.00, 1.5, '12x10x4', 150, 14, 5),
('Brake Pads Ceramic', 'AUTO-B-013', 'Automotive', 'Brakes', 79.99, 28.00, 8.0, '10x8x4', 80, 21, 5),
('Wiper Blades 22inch', 'AUTO-W-014', 'Automotive', 'Accessories', 29.99, 9.50, 1.2, '24x4x2', 120, 14, 5),
('Car Battery 700CCA', 'AUTO-BAT-015', 'Automotive', 'Electrical', 149.99, 55.00, 45.0, '13x7x9', 40, 28, 5),
('Spark Plugs Set-4', 'AUTO-S-016', 'Automotive', 'Ignition', 34.99, 11.00, 0.8, '6x4x2', 100, 14, 5),
('Floor Mats All-Weather', 'AUTO-M-017', 'Automotive', 'Interior', 49.99, 16.00, 6.0, '30x18x2', 70, 21, 7),
('LED Headlight Bulbs', 'AUTO-L-018', 'Automotive', 'Lighting', 69.99, 24.00, 0.6, '6x4x3', 90, 21, 5),
('Coolant Antifreeze 1Gal', 'AUTO-C-019', 'Automotive', 'Fluids', 19.99, 6.50, 9.5, '8x5x10', 200, 14, 5),
('Tire Gauge Digital', 'AUTO-T-020', 'Automotive', 'Tools', 24.99, 8.00, 0.4, '6x3x2', 110, 14, 5),
-- Home & Garden
('LED Bulb 60W 4-Pack', 'HOME-L-021', 'Home & Garden', 'Lighting', 19.99, 5.50, 0.6, '8x6x4', 250, 14, 1),
('Power Drill 20V', 'HOME-D-022', 'Home & Garden', 'Tools', 89.99, 32.00, 4.5, '12x10x4', 50, 21, 10),
('Garden Hose 50ft', 'HOME-H-023', 'Home & Garden', 'Outdoor', 34.99, 11.00, 6.0, '14x14x4', 80, 21, 4),
('Paint Roller Set', 'HOME-P-024', 'Home & Garden', 'Paint', 14.99, 4.50, 1.2, '12x8x3', 150, 7, 4),
('Smoke Detector 3-Pack', 'HOME-S-025', 'Home & Garden', 'Safety', 49.99, 16.00, 1.5, '10x8x4', 100, 21, 1),
('Cordless Screwdriver', 'HOME-CS-026', 'Home & Garden', 'Tools', 39.99, 14.00, 2.0, '10x8x4', 70, 21, 10),
('Outdoor String Lights', 'HOME-OL-027', 'Home & Garden', 'Lighting', 29.99, 9.50, 2.5, '12x10x4', 90, 14, 1),
('Lawn Fertilizer 20lb', 'HOME-F-028', 'Home & Garden', 'Lawn Care', 24.99, 8.00, 20.0, '18x12x6', 120, 14, 8),
('Extension Cord 25ft', 'HOME-EC-029', 'Home & Garden', 'Electrical', 19.99, 6.00, 3.0, '10x8x4', 140, 14, 1),
('Storage Bins 3-Pack', 'HOME-SB-030', 'Home & Garden', 'Storage', 39.99, 13.00, 8.0, '24x18x12', 100, 21, 9),
-- Office Supplies
('Copy Paper 5-Ream', 'OFFICE-P-031', 'Office', 'Paper', 49.99, 18.00, 25.0, '18x12x10', 200, 7, 4),
('Ballpoint Pens 50-Pack', 'OFFICE-BP-032', 'Office', 'Writing', 12.99, 4.00, 1.5, '8x6x2', 300, 7, 4),
('File Folders Letter 100ct', 'OFFICE-F-033', 'Office', 'Filing', 24.99, 8.50, 4.0, '12x10x4', 150, 14, 4),
('Desk Organizer Wood', 'OFFICE-DO-034', 'Office', 'Accessories', 34.99, 12.00, 3.0, '12x6x5', 80, 21, 8),
('Whiteboard 36x24', 'OFFICE-W-035', 'Office', 'Presentation', 49.99, 17.00, 8.0, '38x26x2', 50, 21, 4),
('Label Maker Portable', 'OFFICE-L-036', 'Office', 'Organization', 29.99, 10.00, 0.8, '6x4x2', 90, 21, 3),
('Stapler Heavy Duty', 'OFFICE-S-037', 'Office', 'Supplies', 19.99, 6.50, 1.2, '8x3x2', 120, 14, 1),
('Paper Shredder 12-Sheet', 'OFFICE-PS-038', 'Office', 'Equipment', 79.99, 28.00, 15.0, '16x12x10', 40, 28, 3),
('Desk Lamp LED', 'OFFICE-DL-039', 'Office', 'Lighting', 39.99, 14.00, 2.5, '10x8x14', 100, 21, 1),
('File Cabinet 2-Drawer', 'OFFICE-FC-040', 'Office', 'Furniture', 149.99, 55.00, 65.0, '28x18x29', 30, 35, 8),
-- Sports & Fitness
('Yoga Mat Premium', 'SPORT-Y-041', 'Sports', 'Fitness', 34.99, 11.00, 3.0, '24x6x6', 100, 21, 6),
('Resistance Bands Set', 'SPORT-R-042', 'Sports', 'Fitness', 24.99, 8.00, 1.5, '10x8x3', 120, 14, 6),
('Dumbbells 20lb Pair', 'SPORT-D-043', 'Sports', 'Weights', 49.99, 18.00, 40.0, '12x6x6', 60, 28, 2),
('Water Bottle 32oz', 'SPORT-W-044', 'Sports', 'Accessories', 19.99, 6.50, 0.8, '10x4x4', 200, 14, 9),
('Running Shoes Mens', 'SPORT-RS-045', 'Sports', 'Footwear', 89.99, 32.00, 2.0, '14x8x6', 80, 35, 6),
('Tennis Racket Pro', 'SPORT-T-046', 'Sports', 'Equipment', 129.99, 45.00, 2.5, '28x12x2', 40, 28, 10),
('Basketball Official', 'SPORT-B-047', 'Sports', 'Balls', 29.99, 10.00, 1.5, '10x10x10', 100, 21, 7),
('Jump Rope Speed', 'SPORT-J-048', 'Sports', 'Fitness', 14.99, 4.50, 0.5, '12x6x2', 150, 14, 6),
('Gym Bag Large', 'SPORT-G-049', 'Sports', 'Accessories', 39.99, 13.00, 2.0, '24x12x12', 90, 21, 6),
('Protein Shaker 28oz', 'SPORT-PS-050', 'Sports', 'Nutrition', 12.99, 4.00, 0.5, '8x4x4', 180, 14, 9);

-- =====================================================
-- 6. INSERT CUSTOMERS (30 Customers)
-- =====================================================
INSERT INTO customers (customer_name, customer_type, contact_person, email, phone, city, state, zip_code, credit_limit, customer_since) VALUES
('TechMart Retail', 'Retail', 'Alice Brown', 'alice@techmart.com', '555-1001', 'New York', 'NY', '10001', 500000, '2020-01-15'),
('HomeGoods Plus', 'Retail', 'Bob Martinez', 'bob@homegoods.com', '555-1002', 'Los Angeles', 'CA', '90001', 750000, '2019-06-20'),
('AutoZone Distributors', 'Wholesale', 'Carol White', 'carol@autozone.com', '555-1003', 'Chicago', 'IL', '60601', 1000000, '2018-03-10'),
('Office Supply Hub', 'B2B', 'David Lee', 'david@officesupply.com', '555-1004', 'Boston', 'MA', '02101', 300000, '2021-02-28'),
('Sports Authority', 'Retail', 'Emma Davis', 'emma@sportsauth.com', '555-1005', 'Miami', 'FL', '33101', 600000, '2020-08-12'),
('MegaMart Stores', 'Retail', 'Frank Johnson', 'frank@megamart.com', '555-1006', 'Dallas', 'TX', '75201', 1200000, '2017-11-05'),
('BuildRight Hardware', 'Wholesale', 'Grace Kim', 'grace@buildright.com', '555-1007', 'Seattle', 'WA', '98101', 800000, '2019-09-18'),
('ElectroniX Warehouse', 'Wholesale', 'Henry Chen', 'henry@electronix.com', '555-1008', 'San Francisco', 'CA', '94101', 900000, '2018-12-22'),
('Garden Paradise', 'Retail', 'Iris Martinez', 'iris@gardenparadise.com', '555-1009', 'Phoenix', 'AZ', '85001', 400000, '2020-05-30'),
('FitLife Gyms', 'B2B', 'Jack Wilson', 'jack@fitlife.com', '555-1010', 'Atlanta', 'GA', '30301', 500000, '2021-07-14'),
('QuickStop Convenience', 'Retail', 'Karen Taylor', 'karen@quickstop.com', '555-1011', 'Detroit', 'MI', '48201', 250000, '2022-01-08'),
('Premium Auto Parts', 'Wholesale', 'Leo Anderson', 'leo@premiumauto.com', '555-1012', 'Houston', 'TX', '77001', 700000, '2019-04-25'),
('SmartHome Solutions', 'B2B', 'Maria Garcia', 'maria@smarthome.com', '555-1013', 'Denver', 'CO', '80201', 600000, '2020-10-19'),
('Value Electronics', 'Retail', 'Nathan Thomas', 'nathan@valueelec.com', '555-1014', 'Portland', 'OR', '97201', 450000, '2021-03-07'),
('ProTools Supply', 'Wholesale', 'Olivia Jackson', 'olivia@protools.com', '555-1015', 'Minneapolis', 'MN', '55401', 550000, '2018-08-16'),
('Urban Furniture Co', 'Retail', 'Paul Harris', 'paul@urbanfurn.com', '555-1016', 'Philadelphia', 'PA', '19101', 800000, '2019-11-29'),
('TechSolutions Inc', 'B2B', 'Quinn Martin', 'quinn@techsol.com', '555-1017', 'San Diego', 'CA', '92101', 700000, '2020-06-11'),
('Outdoor Adventures', 'Retail', 'Rachel Lee', 'rachel@outdooradv.com', '555-1018', 'Salt Lake City', 'UT', '84101', 350000, '2021-09-23'),
('BulkBuy Wholesale', 'Wholesale', 'Sam Rodriguez', 'sam@bulkbuy.com', '555-1019', 'Las Vegas', 'NV', '89101', 1500000, '2017-05-14'),
('Corner Store Network', 'Retail', 'Tina White', 'tina@cornerstore.com', '555-1020', 'Nashville', 'TN', '37201', 300000, '2022-04-02'),
('Industrial Supply Co', 'B2B', 'Uma Patel', 'uma@indsupply.com', '555-1021', 'Cleveland', 'OH', '44101', 650000, '2019-07-08'),
('Campus Bookstores', 'Retail', 'Victor Brown', 'victor@campusbook.com', '555-1022', 'Austin', 'TX', '78701', 400000, '2020-11-26'),
('Healthcare Supply', 'B2B', 'Wendy Chang', 'wendy@healthsupply.com', '555-1023', 'Columbus', 'OH', '43201', 500000, '2021-01-19'),
('Discount Depot', 'Retail', 'Xavier Lopez', 'xavier@discountdepot.com', '555-1024', 'Indianapolis', 'IN', '46201', 350000, '2022-03-15'),
('RestaurantGoods Pro', 'B2B', 'Yara Ali', 'yara@restgoods.com', '555-1025', 'Charlotte', 'NC', '28201', 450000, '2020-02-28'),
('Tech Startups Supply', 'B2B', 'Zoe Kim', 'zoe@techstartup.com', '555-1026', 'San Jose', 'CA', '95101', 600000, '2019-12-03'),
('Regional Chain Stores', 'Retail', 'Adam Wilson', 'adam@regional.com', '555-1027', 'Milwaukee', 'WI', '53201', 900000, '2018-06-17'),
('Express Delivery Hub', 'Wholesale', 'Bella Scott', 'bella@expressdelivery.com', '555-1028', 'Kansas City', 'MO', '64101', 550000, '2021-05-09'),
('SmallBiz Suppliers', 'B2B', 'Chris Evans', 'chris@smallbiz.com', '555-1029', 'Oklahoma City', 'OK', '73101', 300000, '2022-02-14'),
('Luxury Retail Group', 'Retail', 'Diana Prince', 'diana@luxuryretail.com', '555-1030', 'Scottsdale', 'AZ', '85251', 1000000, '2019-10-22');

-- =====================================================
-- 7. INSERT INVENTORY (Products across Warehouses)
-- =====================================================
-- Generate inventory for each product in multiple warehouses
INSERT INTO inventory (product_id, warehouse_id, quantity_on_hand, quantity_reserved, last_restock_date)
SELECT 
    p.product_id,
    w.warehouse_id,
    FLOOR(RANDOM() * 500 + 100)::INT as quantity_on_hand,
    FLOOR(RANDOM() * 50)::INT as quantity_reserved,
    DATE '2024-12-31' - FLOOR(RANDOM() * 60)::INT as last_restock_date
FROM products p
CROSS JOIN (SELECT warehouse_id FROM warehouses ORDER BY RANDOM() LIMIT 8) w
WHERE RANDOM() < 0.7; -- 70% chance each product is in each warehouse

-- =====================================================
-- 8. INSERT PURCHASE ORDERS (Historical Data 2022-2024)
-- =====================================================
-- 2022 Purchase Orders
WITH base_dates AS (
    SELECT
        id,
        order_date,
        CASE WHEN RANDOM() < 0.9 THEN order_date + (RANDOM() * 10 + 2)::INT ELSE NULL END AS calculated_delivery_date
    FROM (
        SELECT
            generate_series(1, 200) AS id,
            (DATE '2022-01-01' + (RANDOM() * 365)::INT) AS order_date
    ) AS orders
)
INSERT INTO purchase_orders (po_number, supplier_id, warehouse_id, order_date, expected_delivery_date, actual_delivery_date, status, total_amount, notes)
SELECT 
    'PO-2022-' || LPAD(bd.id::TEXT, 5, '0'),
    (FLOOR(RANDOM() * 10) + 1)::INT,
    (FLOOR(RANDOM() * 12) + 1)::INT,
    bd.order_date,
    bd.order_date + (RANDOM() * 20 + 7)::INT,
    bd.calculated_delivery_date,
    CASE WHEN bd.calculated_delivery_date IS NOT NULL THEN 'Delivered' WHEN RANDOM() > 0.5 THEN 'Shipped' ELSE 'Pending' END,
    ROUND((RANDOM() * 50000 + 5000)::NUMERIC, 2),
    'Bulk order for restocking'
FROM base_dates bd;

-- 2023 Purchase Orders
WITH base_dates AS (
    SELECT
        id,
        order_date,
        CASE WHEN RANDOM() < 0.95 THEN order_date + (RANDOM() * 10 + 2)::INT ELSE NULL END AS calculated_delivery_date
    FROM (
        SELECT
            generate_series(1, 250) AS id,
            (DATE '2023-01-01' + (RANDOM() * 365)::INT) AS order_date
    ) AS orders
)
INSERT INTO purchase_orders (po_number, supplier_id, warehouse_id, order_date, expected_delivery_date, actual_delivery_date, status, total_amount)
SELECT 
    'PO-2023-' || LPAD(bd.id::TEXT, 5, '0'),
    (FLOOR(RANDOM() * 10) + 1)::INT,
    (FLOOR(RANDOM() * 12) + 1)::INT,
    bd.order_date,
    bd.order_date + (RANDOM() * 20 + 7)::INT,
    bd.calculated_delivery_date,
    CASE WHEN bd.calculated_delivery_date IS NOT NULL THEN 'Delivered' WHEN RANDOM() > 0.5 THEN 'Shipped' ELSE 'Pending' END,
    ROUND((RANDOM() * 60000 + 5000)::NUMERIC, 2)
FROM base_dates bd;

-- 2024 Purchase Orders
WITH base_dates AS (
    SELECT
        id,
        order_date,
        CASE WHEN RANDOM() < 0.8 THEN order_date + (RANDOM() * 10 + 2)::INT ELSE NULL END AS calculated_delivery_date
    FROM (
        SELECT
            generate_series(1, 150) AS id,
            (DATE '2024-01-01' + (RANDOM() * 280)::INT) AS order_date
    ) AS orders
)
INSERT INTO purchase_orders (po_number, supplier_id, warehouse_id, order_date, expected_delivery_date, actual_delivery_date, status, total_amount)
SELECT 
    'PO-2024-' || LPAD(bd.id::TEXT, 5, '0'),
    (FLOOR(RANDOM() * 10) + 1)::INT,
    (FLOOR(RANDOM() * 12) + 1)::INT,
    bd.order_date,
    bd.order_date + (RANDOM() * 20 + 7)::INT,
    bd.calculated_delivery_date,
    CASE WHEN bd.calculated_delivery_date IS NOT NULL THEN 'Delivered' WHEN RANDOM() > 0.5 THEN 'Shipped' ELSE 'Pending' END,
    ROUND((RANDOM() * 70000 + 5000)::NUMERIC, 2)
FROM base_dates bd;

-- =====================================================
-- 9. INSERT PURCHASE ORDER ITEMS
-- =====================================================
INSERT INTO purchase_order_items (po_id, product_id, quantity_ordered, quantity_received, unit_cost)
SELECT
    -- Assign each item row to a purchase order using modulo
    (ROW_NUMBER() OVER(ORDER BY p.product_id)) % ((SELECT COUNT(*) FROM purchase_orders)) + 1 AS po_id,
    p.product_id,
    FLOOR(RANDOM() * 500 + 50)::INT AS quantity_ordered,
    0 AS quantity_received, -- Simpler to update this later if needed
    p.unit_cost
FROM
    -- Cross join products and a series to generate many item rows
    products p, generate_series(1, (SELECT COUNT(*) FROM purchase_orders) * 3 / 50);
-- =====================================================
-- 10. INSERT SALES ORDERS (2022-2024)
-- =====================================================
-- 2022 Sales Orders
WITH base_dates AS (
    SELECT
        id,
        order_date,
        CASE WHEN RANDOM() < 0.9 THEN order_date + (RANDOM() * 4 + 1)::INT ELSE NULL END AS calculated_shipped_date
    FROM (
        SELECT generate_series(1, 800) AS id, (DATE '2022-01-01' + (RANDOM() * 365)::INT) AS order_date
    ) AS orders
)
INSERT INTO sales_orders (order_number, customer_id, warehouse_id, order_date, required_date, shipped_date, delivery_date, status, priority, total_amount, shipping_cost)
SELECT 
    'SO-2022-' || LPAD(bd.id::TEXT, 6, '0'),
    (FLOOR(RANDOM() * 30) + 1)::INT,
    (FLOOR(RANDOM() * 12) + 1)::INT,
    bd.order_date,
    bd.order_date + (RANDOM() * 14 + 5)::INT,
    bd.calculated_shipped_date,
    CASE WHEN bd.calculated_shipped_date IS NOT NULL AND RANDOM() < 0.95 THEN bd.calculated_shipped_date + (RANDOM() * 10 + 3)::INT ELSE NULL END,
    CASE WHEN RANDOM() < 0.80 THEN 'Delivered' WHEN RANDOM() < 0.90 THEN 'Shipped' WHEN RANDOM() < 0.95 THEN 'Processing' ELSE 'Cancelled' END,
    CASE WHEN RANDOM() < 0.85 THEN 'Standard' WHEN RANDOM() < 0.95 THEN 'High' ELSE 'Urgent' END,
    ROUND((RANDOM() * 15000 + 500)::NUMERIC, 2),
    ROUND((RANDOM() * 150 + 20)::NUMERIC, 2)
FROM base_dates bd;

-- 2023 Sales Orders
WITH base_dates AS (
    SELECT
        id,
        order_date,
        CASE WHEN RANDOM() < 0.9 THEN order_date + (RANDOM() * 4 + 1)::INT ELSE NULL END AS calculated_shipped_date
    FROM (
        SELECT generate_series(1, 1000) AS id, (DATE '2023-01-01' + (RANDOM() * 365)::INT) AS order_date
    ) AS orders
)
INSERT INTO sales_orders (order_number, customer_id, warehouse_id, order_date, required_date, shipped_date, delivery_date, status, priority, total_amount, shipping_cost)
SELECT 
    'SO-2023-' || LPAD(bd.id::TEXT, 6, '0'),
    (FLOOR(RANDOM() * 30) + 1)::INT,
    (FLOOR(RANDOM() * 12) + 1)::INT,
    bd.order_date,
    bd.order_date + (RANDOM() * 14 + 5)::INT,
    bd.calculated_shipped_date,
    CASE WHEN bd.calculated_shipped_date IS NOT NULL AND RANDOM() < 0.95 THEN bd.calculated_shipped_date + (RANDOM() * 10 + 3)::INT ELSE NULL END,
    CASE WHEN RANDOM() < 0.83 THEN 'Delivered' WHEN RANDOM() < 0.92 THEN 'Shipped' WHEN RANDOM() < 0.97 THEN 'Processing' ELSE 'Cancelled' END,
    CASE WHEN RANDOM() < 0.85 THEN 'Standard' WHEN RANDOM() < 0.95 THEN 'High' ELSE 'Urgent' END,
    ROUND((RANDOM() * 18000 + 500)::NUMERIC, 2),
    ROUND((RANDOM() * 170 + 20)::NUMERIC, 2)
FROM base_dates bd;

-- 2024 Sales Orders
WITH base_dates AS (
    SELECT
        id,
        order_date,
        CASE WHEN RANDOM() < 0.8 THEN order_date + (RANDOM() * 4 + 1)::INT ELSE NULL END AS calculated_shipped_date
    FROM (
        SELECT generate_series(1, 600) AS id, (DATE '2024-01-01' + (RANDOM() * 280)::INT) AS order_date
    ) AS orders
)
INSERT INTO sales_orders (order_number, customer_id, warehouse_id, order_date, required_date, shipped_date, delivery_date, status, priority, total_amount, shipping_cost)
SELECT 
    'SO-2024-' || LPAD(bd.id::TEXT, 6, '0'),
    (FLOOR(RANDOM() * 30) + 1)::INT,
    (FLOOR(RANDOM() * 12) + 1)::INT,
    bd.order_date,
    bd.order_date + (RANDOM() * 14 + 5)::INT,
    bd.calculated_shipped_date,
    CASE WHEN bd.calculated_shipped_date IS NOT NULL AND RANDOM() < 0.95 THEN bd.calculated_shipped_date + (RANDOM() * 10 + 3)::INT ELSE NULL END,
    CASE WHEN RANDOM() < 0.65 THEN 'Delivered' WHEN RANDOM() < 0.80 THEN 'Shipped' WHEN RANDOM() < 0.95 THEN 'Processing' ELSE 'Pending' END,
    CASE WHEN RANDOM() < 0.85 THEN 'Standard' WHEN RANDOM() < 0.95 THEN 'High' ELSE 'Urgent' END,
    ROUND((RANDOM() * 20000 + 500)::NUMERIC, 2),
    ROUND((RANDOM() * 200 + 20)::NUMERIC, 2)
FROM base_dates bd;

-- =====================================================
-- 11. INSERT SALES ORDER ITEMS
-- =====================================================
INSERT INTO sales_order_items (order_id, product_id, quantity, unit_price, discount_percent)
SELECT
    -- Assign each item row to a sales order using modulo
    (ROW_NUMBER() OVER(ORDER BY p.product_id)) % ((SELECT COUNT(*) FROM sales_orders)) + 1 AS order_id,
    p.product_id,
    FLOOR(RANDOM() * 20 + 1)::INT AS quantity,
    p.unit_price,
    CASE WHEN RANDOM() < 0.3 THEN ROUND((RANDOM() * 15)::NUMERIC, 2) ELSE 0 END AS discount_percent
FROM
    -- Cross join products and a series to generate many item rows
    products p, generate_series(1, (SELECT COUNT(*) FROM sales_orders) * 2 / 50);
-- =====================================================
-- 12. INSERT SHIPMENTS (Corrected)
-- =====================================================
INSERT INTO shipments (tracking_number, order_id, carrier_id, warehouse_id, ship_date, estimated_delivery, actual_delivery, status, shipping_cost, weight_lbs, distance_miles)
SELECT 
    'TRK-' || LPAD(so.order_id::TEXT, 10, '0') || '-' || LPAD((ROW_NUMBER() OVER())::TEXT, 4, '0'),
    so.order_id,
    (FLOOR(RANDOM() * 10) + 1)::INT,
    so.warehouse_id,
    so.shipped_date,
    so.shipped_date + (RANDOM() * 7 + 2)::INT,
    so.delivery_date,
    CASE 
        WHEN so.delivery_date IS NOT NULL THEN 'Delivered'
        WHEN so.shipped_date IS NOT NULL THEN 'In Transit'
        ELSE 'Preparing'
    END,
    so.shipping_cost,
    ROUND((RANDOM() * 100 + 5)::NUMERIC, 2),
    FLOOR(RANDOM() * 2000 + 100)::INT
FROM sales_orders so
WHERE so.status IN ('Shipped', 'Delivered');


-- =====================================================
-- 13. INSERT INVENTORY MOVEMENTS (Corrected)
-- =====================================================
INSERT INTO inventory_movements (product_id, from_warehouse_id, to_warehouse_id, quantity, movement_type, movement_date, reason, reference_number, created_by)
SELECT 
    (FLOOR(RANDOM() * 50) + 1)::INT,
    (FLOOR(RANDOM() * 12) + 1)::INT,
    (FLOOR(RANDOM() * 12) + 1)::INT,
    FLOOR(RANDOM() * 100 + 10)::INT,
    CASE 
        WHEN RANDOM() < 0.6 THEN 'Transfer'
        WHEN RANDOM() < 0.85 THEN 'Adjustment'
        WHEN RANDOM() < 0.95 THEN 'Return'
        ELSE 'Damage'
    END,
    DATE '2023-01-01' + (RANDOM() * 600)::INT,
    CASE 
        WHEN RANDOM() < 0.5 THEN 'Rebalancing stock levels'
        WHEN RANDOM() < 0.75 THEN 'Seasonal demand'
        ELSE 'Warehouse optimization'
    END,
    'MV-' || LPAD(s.series_num::TEXT, 6, '0'), -- Uses the alias s.series_num
    'System'
FROM generate_series(1, 300) AS s(series_num); -- Adds the alias s(series_num)

-- =====================================================
-- 14. INSERT SUPPLIER PERFORMANCE
-- =====================================================
INSERT INTO supplier_performance (supplier_id, evaluation_date, on_time_delivery_rate, quality_rating, total_orders, total_defects, average_lead_time_days, total_purchase_value)
SELECT 
    s.supplier_id,
    DATE '2023-01-01' + (generate_series * 90)::INT,
    ROUND((RANDOM() * 20 + 75)::NUMERIC, 2),
    ROUND((RANDOM() * 2 + 3)::NUMERIC, 2),
    FLOOR(RANDOM() * 50 + 10)::INT,
    FLOOR(RANDOM() * 10)::INT,
    FLOOR(RANDOM() * 20 + 10)::INT,
    ROUND((RANDOM() * 500000 + 100000)::NUMERIC, 2)
FROM suppliers s
CROSS JOIN generate_series(0, 7);

-- =====================================================
-- DATA GENERATION COMPLETE
-- =====================================================

SELECT 'Sample data generated successfully!' AS message,
(SELECT COUNT(*) FROM regions) AS regions_count,
(SELECT COUNT(*) FROM warehouses) AS warehouses_count,
(SELECT COUNT(*) FROM suppliers) AS suppliers_count,
(SELECT COUNT(*) FROM products) AS products_count,
(SELECT COUNT(*) FROM customers) AS customers_count,
(SELECT COUNT(*) FROM inventory) AS inventory_records,
(SELECT COUNT(*) FROM purchase_orders) AS purchase_orders_count,
(SELECT COUNT(*) FROM sales_orders) AS sales_orders_count,
(SELECT COUNT(*) FROM shipments) AS shipments_count,
(SELECT COUNT(*) FROM inventory_movements) AS movements_count;