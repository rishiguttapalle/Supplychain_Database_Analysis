-- =====================================================
-- TABLEAU DASHBOARD VIEWS 
-- =====================================================

-- =====================================================
-- STEP 1: DROP ALL EXISTING VIEWS FOR A CLEAN SLATE
-- =====================================================
DROP VIEW IF EXISTS vw_sales_dashboard;
DROP VIEW IF EXISTS vw_inventory_summary;
DROP VIEW IF EXISTS vw_order_metrics;
DROP VIEW IF EXISTS vw_customer_analysis;
DROP VIEW IF EXISTS vw_product_performance;

-- View 1: Sales Dashboard
CREATE VIEW vw_sales_dashboard AS
SELECT
    so.order_id,
    so.order_number,
    so.order_date,
    EXTRACT(YEAR FROM so.order_date) AS order_year,
    EXTRACT(MONTH FROM so.order_date) AS order_month,
    TO_CHAR(so.order_date, 'YYYY-MM') AS year_month,
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.city AS customer_city,
    c.state AS customer_state,
    w.warehouse_id,
    w.warehouse_name,
    w.city AS warehouse_city,
    w.state AS warehouse_state,
    r.region_id,
    r.region_name,
    so.status,
    so.priority,
    so.total_amount,
    so.shipping_cost,
    CASE WHEN so.delivery_date <= so.required_date THEN 1 ELSE 0 END AS is_on_time,
    CASE WHEN so.delivery_date IS NOT NULL THEN so.delivery_date - so.order_date ELSE NULL END AS fulfillment_days,
    COUNT(soi.order_item_id) AS items_count,
    SUM(soi.quantity) AS total_units
FROM sales_orders so
INNER JOIN customers c ON so.customer_id = c.customer_id
INNER JOIN warehouses w ON so.warehouse_id = w.warehouse_id
INNER JOIN regions r ON w.region_id = r.region_id
LEFT JOIN sales_order_items soi ON so.order_id = soi.order_id
GROUP BY so.order_id, c.customer_id, w.warehouse_id, r.region_id;

-- View 2: Inventory Summary (No changes needed)
CREATE VIEW vw_inventory_summary AS
SELECT
    w.warehouse_name,
    w.city,
    w.state,
    p.product_name,
    p.sku,
    p.category,
    i.quantity_on_hand,
    i.quantity_reserved,
    i.quantity_available,
    p.unit_price,
    (i.quantity_available * p.unit_price) AS inventory_value,
    p.reorder_point,
    CASE
        WHEN i.quantity_available <= p.reorder_point THEN 'Reorder Needed'
        WHEN i.quantity_available <= p.reorder_point * 1.5 THEN 'Low Stock'
        ELSE 'Adequate'
    END AS stock_status
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN warehouses w ON i.warehouse_id = w.warehouse_id;

-- View 3: Order Metrics (No changes needed)
CREATE VIEW vw_order_metrics AS
SELECT
    so.order_id,
    so.order_number,
    c.customer_name,
    so.order_date,
    so.required_date,
    so.shipped_date,
    so.delivery_date,
    so.status,
    so.total_amount,
    CASE
        WHEN so.delivery_date IS NOT NULL AND so.required_date IS NOT NULL
        THEN so.delivery_date - so.required_date
        ELSE NULL
    END AS days_early_late,
    CASE
        WHEN so.delivery_date <= so.required_date THEN TRUE
        WHEN so.delivery_date IS NULL AND DATE '2024-12-31' > so.required_date THEN FALSE
        ELSE NULL
    END AS on_time_delivery
FROM sales_orders so
JOIN customers c ON so.customer_id = c.customer_id;

-- View 4: Customer Analysis (No changes needed)
CREATE VIEW vw_customer_analysis AS
SELECT 
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.city,
    c.state,
    COUNT(so.order_id) AS total_orders,
    ROUND(SUM(so.total_amount), 2) AS lifetime_value,
    ROUND(AVG(so.total_amount), 2) AS avg_order_value,
    MIN(so.order_date) AS first_order_date,
    MAX(so.order_date) AS last_order_date,
    DATE '2024-12-31' - MAX(so.order_date) AS days_since_last_order,
    CASE 
        WHEN DATE '2024-12-31' - MAX(so.order_date) <= 30 THEN 'Active'
        WHEN DATE '2024-12-31' - MAX(so.order_date) <= 90 THEN 'At Risk'
        ELSE 'Inactive'
    END AS customer_status,
    CASE 
        WHEN COUNT(so.order_id) >= 20 THEN 'VIP'
        WHEN COUNT(so.order_id) >= 10 THEN 'Premium'
        ELSE 'Regular'
    END AS customer_segment
FROM customers c
LEFT JOIN sales_orders so ON c.customer_id = so.customer_id
WHERE so.status != 'Cancelled' OR so.status IS NULL
GROUP BY c.customer_id, c.customer_name, c.customer_type, c.city, c.state;

-- View 5: Product Performance 
CREATE VIEW vw_product_performance AS
SELECT 
    p.product_id,
    p.product_name,
    p.sku,
    p.category,
    p.subcategory,
    p.unit_price,
    p.unit_cost,
    COUNT(DISTINCT soi.order_id) AS times_ordered,
    SUM(soi.quantity) AS total_units_sold,
    ROUND(SUM(soi.line_total), 2) AS total_revenue,
    ROUND(SUM(soi.quantity * p.unit_cost), 2) AS total_cost,
    ROUND(SUM(soi.line_total) - SUM(soi.quantity * p.unit_cost), 2) AS total_profit,
    ROUND(
        ((SUM(soi.line_total) - SUM(soi.quantity * p.unit_cost)) / 
        NULLIF(SUM(soi.line_total), 0)), 
        2
    ) AS profit_margin_percent
FROM products p
LEFT JOIN sales_order_items soi ON p.product_id = soi.product_id
LEFT JOIN sales_orders so ON soi.order_id = so.order_id
WHERE so.status != 'Cancelled' OR so.status IS NULL
GROUP BY p.product_id;

-- Verification: Test all views
SELECT 'vw_sales_dashboard' AS view_name, COUNT(*) AS record_count FROM vw_sales_dashboard
UNION ALL
SELECT 'vw_inventory_summary', COUNT(*) FROM vw_inventory_summary
UNION ALL
SELECT 'vw_customer_analysis', COUNT(*) FROM vw_customer_analysis
UNION ALL
SELECT 'vw_product_performance', COUNT(*) FROM vw_product_performance;