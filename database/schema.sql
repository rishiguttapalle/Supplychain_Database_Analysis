-- =====================================================
-- SUPPLY CHAIN DATABASE SCHEMA
-- Database: PostgreSQL 14+
-- =====================================================

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS supplier_performance CASCADE;
DROP TABLE IF EXISTS inventory_movements CASCADE;
DROP TABLE IF EXISTS shipments CASCADE;
DROP TABLE IF EXISTS sales_order_items CASCADE;   
DROP TABLE IF EXISTS sales_orders CASCADE;
DROP TABLE IF EXISTS purchase_order_items CASCADE; 
DROP TABLE IF EXISTS purchase_orders CASCADE;
DROP TABLE IF EXISTS inventory CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS carriers CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS warehouses CASCADE;
DROP TABLE IF EXISTS regions CASCADE;

-- =====================================================
-- 1. REGIONS TABLE
-- =====================================================
CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    region_manager VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 2. WAREHOUSES TABLE
-- =====================================================
CREATE TABLE warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    warehouse_name VARCHAR(100) NOT NULL,
    region_id INT REFERENCES regions(region_id),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    capacity_sqft INT,
    warehouse_type VARCHAR(50), -- Distribution, Fulfillment, Cold Storage
    operational_status VARCHAR(20) DEFAULT 'Active', -- Active, Maintenance, Closed
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 3. SUPPLIERS TABLE
-- =====================================================
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100),
    supplier_category VARCHAR(50), -- Raw Materials, Finished Goods, Packaging
    payment_terms VARCHAR(50), -- Net 30, Net 60, etc.
    rating DECIMAL(3,2), -- 1.00 to 5.00
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 4. CARRIERS TABLE
-- =====================================================
CREATE TABLE carriers (
    carrier_id SERIAL PRIMARY KEY,
    carrier_name VARCHAR(100) NOT NULL,
    carrier_type VARCHAR(50), -- Ground, Air, Ocean, Rail
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    service_level VARCHAR(50), -- Standard, Express, Overnight
    base_rate DECIMAL(10,2),
    rating DECIMAL(3,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 5. PRODUCTS TABLE
-- =====================================================
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    sku VARCHAR(50) UNIQUE NOT NULL,
    category VARCHAR(100),
    subcategory VARCHAR(100),
    unit_price DECIMAL(10,2),
    unit_cost DECIMAL(10,2),
    weight_lbs DECIMAL(8,2),
    dimensions VARCHAR(50), -- e.g., "10x8x6"
    reorder_point INT, -- Minimum stock level before reorder
    lead_time_days INT, -- Time to receive from supplier
    supplier_id INT REFERENCES suppliers(supplier_id),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 6. CUSTOMERS TABLE
-- =====================================================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    customer_type VARCHAR(50), -- Retail, Wholesale, B2B
    contact_person VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(50),
    zip_code VARCHAR(20),
    credit_limit DECIMAL(12,2),
    customer_since DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 7. INVENTORY TABLE
-- =====================================================
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    warehouse_id INT REFERENCES warehouses(warehouse_id),
    quantity_on_hand INT DEFAULT 0,
    quantity_reserved INT DEFAULT 0, -- Reserved for orders
    quantity_available INT GENERATED ALWAYS AS (quantity_on_hand - quantity_reserved) STORED,
    last_restock_date DATE,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(product_id, warehouse_id)
);

-- =====================================================
-- 8. PURCHASE ORDERS TABLE
-- =====================================================
CREATE TABLE purchase_orders (
    po_id SERIAL PRIMARY KEY,
    po_number VARCHAR(50) UNIQUE NOT NULL,
    supplier_id INT REFERENCES suppliers(supplier_id),
    warehouse_id INT REFERENCES warehouses(warehouse_id),
    order_date DATE NOT NULL,
    expected_delivery_date DATE,
    actual_delivery_date DATE,
    status VARCHAR(50) DEFAULT 'Pending', -- Pending, Shipped, Delivered, Cancelled
    total_amount DECIMAL(12,2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 9. PURCHASE ORDER ITEMS TABLE
-- =====================================================
CREATE TABLE purchase_order_items (
    po_item_id SERIAL PRIMARY KEY,
    po_id INT REFERENCES purchase_orders(po_id),
    product_id INT REFERENCES products(product_id),
    quantity_ordered INT NOT NULL,
    quantity_received INT DEFAULT 0,
    unit_cost DECIMAL(10,2),
    total_cost DECIMAL(12,2) GENERATED ALWAYS AS (quantity_ordered * unit_cost) STORED
);

-- =====================================================
-- 10. SALES ORDERS TABLE
-- =====================================================
CREATE TABLE sales_orders (
    order_id SERIAL PRIMARY KEY,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT REFERENCES customers(customer_id),
    warehouse_id INT REFERENCES warehouses(warehouse_id),
    order_date DATE NOT NULL,
    required_date DATE,
    shipped_date DATE,
    delivery_date DATE,
    status VARCHAR(50) DEFAULT 'Pending', -- Pending, Processing, Shipped, Delivered, Cancelled
    priority VARCHAR(20) DEFAULT 'Standard', -- Standard, High, Urgent
    total_amount DECIMAL(12,2),
    shipping_cost DECIMAL(10,2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 11. SALES ORDER ITEMS TABLE
-- =====================================================
CREATE TABLE sales_order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES sales_orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2) DEFAULT 0,
    line_total DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price * (1 - discount_percent/100)) STORED
);

-- =====================================================
-- 12. SHIPMENTS TABLE
-- =====================================================
CREATE TABLE shipments (
    shipment_id SERIAL PRIMARY KEY,
    tracking_number VARCHAR(100) UNIQUE NOT NULL,
    order_id INT REFERENCES sales_orders(order_id),
    carrier_id INT REFERENCES carriers(carrier_id),
    warehouse_id INT REFERENCES warehouses(warehouse_id),
    ship_date DATE,
    estimated_delivery DATE,
    actual_delivery DATE,
    status VARCHAR(50) DEFAULT 'Preparing', -- Preparing, In Transit, Delivered, Failed
    shipping_cost DECIMAL(10,2),
    weight_lbs DECIMAL(10,2),
    distance_miles INT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 13. INVENTORY MOVEMENTS TABLE
-- =====================================================
CREATE TABLE inventory_movements (
    movement_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    from_warehouse_id INT REFERENCES warehouses(warehouse_id),
    to_warehouse_id INT REFERENCES warehouses(warehouse_id),
    quantity INT NOT NULL,
    movement_type VARCHAR(50), -- Transfer, Adjustment, Return, Damage
    movement_date DATE NOT NULL,
    reason TEXT,
    reference_number VARCHAR(50),
    created_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- 14. SUPPLIER PERFORMANCE TABLE
-- =====================================================
CREATE TABLE supplier_performance (
    performance_id SERIAL PRIMARY KEY,
    supplier_id INT REFERENCES suppliers(supplier_id),
    evaluation_date DATE NOT NULL,
    on_time_delivery_rate DECIMAL(5,2), -- Percentage
    quality_rating DECIMAL(3,2), -- 1.00 to 5.00
    total_orders INT,
    total_defects INT,
    average_lead_time_days INT,
    total_purchase_value DECIMAL(15,2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- CREATE INDEXES FOR PERFORMANCE
-- =====================================================

-- Inventory lookups
CREATE INDEX idx_inventory_product ON inventory(product_id);
CREATE INDEX idx_inventory_warehouse ON inventory(warehouse_id);

-- Order lookups
CREATE INDEX idx_sales_orders_customer ON sales_orders(customer_id);
CREATE INDEX idx_sales_orders_date ON sales_orders(order_date);
CREATE INDEX idx_sales_orders_status ON sales_orders(status);

-- Purchase orders
CREATE INDEX idx_purchase_orders_supplier ON purchase_orders(supplier_id);
CREATE INDEX idx_purchase_orders_date ON purchase_orders(order_date);

-- Shipments
CREATE INDEX idx_shipments_order ON shipments(order_id);
CREATE INDEX idx_shipments_carrier ON shipments(carrier_id);
CREATE INDEX idx_shipments_status ON shipments(status);

-- Products
CREATE INDEX idx_products_supplier ON products(supplier_id);
CREATE INDEX idx_products_category ON products(category);


-- =====================================================
-- SCHEMA CREATION COMPLETE
-- =====================================================

SELECT 'Database schema created successfully!' AS message;