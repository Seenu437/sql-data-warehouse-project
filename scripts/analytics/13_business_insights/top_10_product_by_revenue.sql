/*
===============================================================================
Business Insight 4: Top 10 Products by Revenue
===============================================================================

Business Question:
    Which products generate the highest revenue?

Business Value:
    Identifying the top-performing products helps the business:
        • Recognize best-selling products.
        • Prioritize inventory management.
        • Improve marketing and promotional strategies.
        • Support product portfolio optimization.

SQL Concepts Used:
    • INNER JOIN
    • GROUP BY
    • Aggregate Functions (SUM, COUNT, AVG)
    • ORDER BY
    • TOP

Expected Power BI Visualization:
    • Horizontal Bar Chart
    • Treemap

===============================================================================
*/

SELECT TOP (10)
    p.product_key,
    p.product_name,
    p.category,
    p.subcategory,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue,
    ROUND(AVG(f.sales_amount), 2) AS average_order_value
FROM gold.fact_sales AS f
INNER JOIN gold.dim_products AS p
    ON f.product_key = p.product_key
GROUP BY
    p.product_key,
    p.product_name,
    p.category,
    p.subcategory
ORDER BY
    total_revenue DESC;
