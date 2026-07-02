/*
===============================================================================
Business Insight 3: Revenue Analysis by Product Category
===============================================================================

Business Question:
    Which product categories generate the highest revenue?

Business Value:
    Understanding category-level sales performance helps the business:
        • Identify the most profitable product categories.
        • Optimize inventory planning and purchasing decisions.
        • Prioritize marketing campaigns for high-performing categories.
        • Evaluate underperforming categories for improvement or discontinuation.

SQL Concepts Used:
    • INNER JOIN
    • GROUP BY
    • Aggregate Functions (SUM, COUNT, AVG)
    • ORDER BY
    • ROUND

Expected Power BI Visualization:
    • Treemap
    • Clustered Bar Chart
    • Donut Chart

===============================================================================
*/

SELECT
    p.category,
    COUNT(DISTINCT p.product_key) AS total_products,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue,
    ROUND(AVG(f.sales_amount), 2) AS average_order_value
FROM gold.fact_sales AS f
INNER JOIN gold.dim_products AS p
    ON f.product_key = p.product_key
GROUP BY
    p.category
ORDER BY
    total_revenue DESC;
