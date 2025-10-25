--=====================================================
-- SQL QUERIES 
-- =====================================================

-- =====================================================
-- QUERY 1: Total Sales Revenue by Year and Quarter
-- =====================================================
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(QUARTER FROM order_date) AS quarter,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    SUM(shipping_cost) AS total_shipping_cost
FROM sales_orders
WHERE status != 'Cancelled'
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date)
ORDER BY year, quarter;

-- Business Insight: Shows revenue trends and seasonality


-- =====================================================
-- QUERY 2: Top 10 Best-Selling Products
-- =====================================================
SELECT 
    p.product_name,
    p.sku,
    p.category,
    COUNT(DISTINCT soi.order_id) AS times_ordered,
    SUM(soi.quantity) AS total_units_sold,
    ROUND(SUM(soi.line_total), 2) AS total_revenue,
    ROUND(AVG(soi.unit_price), 2) AS avg_selling_price
FROM products p
INNER JOIN sales_order_items soi ON p.product_id = soi.product_id
INNER JOIN sales_orders so ON soi.order_id = so.order_id
WHERE so.status != 'Cancelled'
GROUP BY p.product_id, p.product_name, p.sku, p.category
ORDER BY total_revenue DESC
LIMIT 10;

-- Business Insight: Identifies most profitable products


-- =====================================================
-- QUERY 3: Inventory Status - Products Below Reorder Point
-- =====================================================
SELECT 
    w.warehouse_name,
    w.city,
    w.state,
    p.product_name,
    p.sku,
    p.category,
    i.quantity_available,
    p.reorder_point,
    (p.reorder_point - i.quantity_available) AS units_needed,
    ROUND(i.quantity_available * p.unit_price, 2) AS current_inventory_value,
    s.supplier_name,
    p.lead_time_days
FROM inventory i
INNER JOIN products p ON i.product_id = p.product_id
INNER JOIN warehouses w ON i.warehouse_id = w.warehouse_id
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE i.quantity_available <= p.reorder_point
ORDER BY (p.reorder_point - i.quantity_available) DESC;

-- Business Insight: Shows which products need urgent restocking


-- =====================================================
-- QUERY 4: Customer Purchase Behavior Analysis
-- =====================================================
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
    MAX(so.order_date) AS most_recent_order,
    DATE '2024-12-31' - MAX(so.order_date) AS days_since_last_order
FROM customers c
LEFT JOIN sales_orders so ON c.customer_id = so.customer_id
WHERE so.status != 'Cancelled' OR so.status IS NULL
GROUP BY c.customer_id, c.customer_name, c.customer_type, c.city, c.state
ORDER BY lifetime_value DESC;

-- Business Insight: Identifies most valuable customers


-- =====================================================
-- QUERY 5: On-Time Delivery Performance by Warehouse
-- =====================================================
SELECT 
    w.warehouse_name,
    w.city,
    w.state,
    COUNT(so.order_id) AS total_orders,
    SUM(CASE WHEN so.delivery_date <= so.required_date THEN 1 ELSE 0 END) AS on_time_deliveries,
    SUM(CASE WHEN so.delivery_date > so.required_date THEN 1 ELSE 0 END) AS late_deliveries,
    ROUND(
        (SUM(CASE WHEN so.delivery_date <= so.required_date THEN 1 ELSE 0 END)::NUMERIC / 
        COUNT(so.order_id)) * 100, 
        2
    ) AS on_time_percentage,
    ROUND(AVG(so.delivery_date - so.order_date), 1) AS avg_fulfillment_days
FROM warehouses w
INNER JOIN sales_orders so ON w.warehouse_id = so.warehouse_id
WHERE so.status = 'Delivered'
GROUP BY w.warehouse_id, w.warehouse_name, w.city, w.state
ORDER BY on_time_percentage DESC;

-- Business Insight: Shows which warehouses are most efficient


-- =====================================================
-- QUERY 6: Monthly Sales Trends (Last 12 Months)
-- =====================================================
SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS monthly_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_orders
WHERE order_date >= DATE '2024-12-31' - INTERVAL '12 months'
    AND status != 'Cancelled'
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- Business Insight: Identifies seasonal patterns and trends


-- =====================================================
-- QUERY 7: Product Category Performance Comparison
-- =====================================================
SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) AS product_count,
    COUNT(DISTINCT soi.order_id) AS total_orders,
    SUM(soi.quantity) AS total_units_sold,
    ROUND(SUM(soi.line_total), 2) AS total_revenue,
    ROUND(AVG(soi.line_total), 2) AS avg_revenue_per_order,
    ROUND(SUM(soi.quantity * p.unit_cost), 2) AS total_cost,
    ROUND(SUM(soi.line_total) - SUM(soi.quantity * p.unit_cost), 2) AS total_profit,
    ROUND(
        ((SUM(soi.line_total) - SUM(soi.quantity * p.unit_cost)) / 
        NULLIF(SUM(soi.line_total), 0)) * 100, 
        2
    ) AS profit_margin_percent
FROM products p
INNER JOIN sales_order_items soi ON p.product_id = soi.product_id
INNER JOIN sales_orders so ON soi.order_id = so.order_id
WHERE so.status != 'Cancelled'
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Business Insight: Shows which product categories are most profitable

-- =====================================================
-- QUERY 8: Inventory Value by Warehouse and Category
-- =====================================================
SELECT 
    w.warehouse_name,
    w.city,
    w.state,
    p.category,
    COUNT(DISTINCT p.product_id) AS product_count,
    SUM(i.quantity_on_hand) AS total_units_in_stock,
    SUM(i.quantity_reserved) AS total_units_reserved,
    SUM(i.quantity_available) AS total_units_available,
    ROUND(SUM(i.quantity_on_hand * p.unit_price), 2) AS inventory_value_retail,
    ROUND(SUM(i.quantity_on_hand * p.unit_cost), 2) AS inventory_value_cost,
    ROUND(SUM(i.quantity_on_hand * (p.unit_price - p.unit_cost)), 2) AS potential_profit
FROM warehouses w
INNER JOIN inventory i ON w.warehouse_id = i.warehouse_id
INNER JOIN products p ON i.product_id = p.product_id
GROUP BY w.warehouse_id, w.warehouse_name, w.city, w.state, p.category
ORDER BY w.warehouse_name, inventory_value_retail DESC;

-- Business Insight: Shows inventory distribution and value by location


-- =====================================================
-- QUERY 9: Customer Segmentation (RFM Analysis)
-- =====================================================
SELECT 
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.city,
    c.state,
    COUNT(so.order_id) AS frequency,
    ROUND(SUM(so.total_amount), 2) AS monetary_value,
    MAX(so.order_date) AS last_order_date,
    DATE '2024-12-31' - MAX(so.order_date) AS recency_days,
    CASE 
        WHEN (DATE '2024-12-31' - MAX(so.order_date)) <= 30 THEN 'Very Active'
        WHEN (DATE '2024-12-31' - MAX(so.order_date)) <= 90 THEN 'Active'
        WHEN (DATE '2024-12-31' - MAX(so.order_date)) <= 180 THEN 'At Risk'
        ELSE 'Inactive'
    END AS customer_status,
    CASE 
        WHEN COUNT(so.order_id) >= 20 AND SUM(so.total_amount) >= 100000 THEN 'VIP'
        WHEN COUNT(so.order_id) >= 10 AND SUM(so.total_amount) >= 50000 THEN 'Premium'
        WHEN COUNT(so.order_id) >= 5 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment
FROM customers c
LEFT JOIN sales_orders so ON c.customer_id = so.customer_id
WHERE so.status != 'Cancelled' OR so.status IS NULL
GROUP BY c.customer_id, c.customer_name, c.customer_type, c.city, c.state
ORDER BY monetary_value DESC;

-- Business Insight: Segments customers for targeted marketing


-- =====================================================
-- QUERY 10: Average Order Processing Time by Priority
-- =====================================================
SELECT 
    priority,
    status,
    COUNT(order_id) AS order_count,
    ROUND(AVG(shipped_date - order_date), 1) AS avg_days_to_ship,
    ROUND(AVG(delivery_date - order_date), 1) AS avg_days_to_deliver,
    ROUND(AVG(delivery_date - required_date), 1) AS avg_delay_vs_required,
    MIN(delivery_date - order_date) AS fastest_delivery,
    MAX(delivery_date - order_date) AS slowest_delivery
FROM sales_orders
WHERE status = 'Delivered'
    AND shipped_date IS NOT NULL 
    AND delivery_date IS NOT NULL
GROUP BY priority, status
ORDER BY 
    CASE priority 
        WHEN 'Urgent' THEN 1 
        WHEN 'High' THEN 2 
        WHEN 'Standard' THEN 3 
    END;

-- Business Insight: Shows if priority orders are truly prioritized


-- =====================================================
-- QUERY 11: Year-over-Year Growth Analysis
-- =====================================================
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    COUNT(DISTINCT customer_id) AS unique_customers,
    LAG(COUNT(order_id)) OVER (ORDER BY EXTRACT(YEAR FROM order_date)) AS prev_year_orders,
    LAG(ROUND(SUM(total_amount), 2)) OVER (ORDER BY EXTRACT(YEAR FROM order_date)) AS prev_year_revenue,
    ROUND(
        ((COUNT(order_id)::NUMERIC - LAG(COUNT(order_id)) OVER (ORDER BY EXTRACT(YEAR FROM order_date))) / 
        NULLIF(LAG(COUNT(order_id)) OVER (ORDER BY EXTRACT(YEAR FROM order_date)), 0)) * 100,
        2
    ) AS order_growth_percent,
    ROUND(
        ((SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY EXTRACT(YEAR FROM order_date))) / 
        NULLIF(LAG(SUM(total_amount)) OVER (ORDER BY EXTRACT(YEAR FROM order_date)), 0)) * 100,
        2
    ) AS revenue_growth_percent
FROM sales_orders
WHERE status != 'Cancelled'
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;

-- Business Insight: Shows business growth trajectory over time


-- =====================================================
-- QUERY 12: Complete Order Summary Report
-- =====================================================
SELECT 
    so.order_number,
    so.order_date,
    c.customer_name,
    c.customer_type,
    w.warehouse_name,
    w.city AS warehouse_city,
    so.status,
    so.priority,
    COUNT(soi.order_item_id) AS items_count,
    SUM(soi.quantity) AS total_units,
    ROUND(SUM(soi.line_total), 2) AS subtotal,
    so.shipping_cost,
    so.total_amount,
    ca.carrier_name,
    s.tracking_number,
    so.required_date,
    so.delivery_date,
    CASE 
        WHEN so.delivery_date IS NULL THEN NULL
        WHEN so.delivery_date <= so.required_date THEN 'On Time'
        ELSE 'Late'
    END AS delivery_status,
    CASE 
        WHEN so.delivery_date IS NOT NULL THEN so.delivery_date - so.order_date
        ELSE NULL
    END AS total_fulfillment_days
FROM sales_orders so
INNER JOIN customers c ON so.customer_id = c.customer_id
INNER JOIN warehouses w ON so.warehouse_id = w.warehouse_id
LEFT JOIN sales_order_items soi ON so.order_id = soi.order_id
LEFT JOIN shipments s ON so.order_id = s.order_id
LEFT JOIN carriers ca ON s.carrier_id = ca.carrier_id
WHERE so.order_date >= DATE '2024-12-31' - INTERVAL '6 months'
GROUP BY 
    so.order_id, so.order_number, so.order_date, c.customer_name, c.customer_type,
    w.warehouse_name, w.city, so.status, so.priority, so.shipping_cost, so.total_amount,
    ca.carrier_name, s.tracking_number, so.required_date, so.delivery_date
ORDER BY so.order_date DESC
LIMIT 100;
