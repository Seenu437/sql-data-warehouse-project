/*
===============================================================================
Business Insight 2: Revenue Analysis by Country
===============================================================================

Business Question:
    Which countries generate the highest revenue?

Business Value:
    Understanding geographical sales performance helps the business:
        • Identify high-performing markets.
        • Allocate marketing budgets effectively.
        • Support regional expansion strategies.
        • Discover underperforming regions that require attention.

SQL Concepts Used:
    • INNER JOIN
    • GROUP BY
    • Aggregate Functions (SUM, COUNT, AVG)
    • ORDER BY
    • ROUND

Expected Power BI Visualization:
    • Filled Map
    • Horizontal Bar Chart

===============================================================================
*/

SELECT
    c.country,
    COUNT(DISTINCT c.customer_key) AS total_customers,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.sales_amount) AS total_revenue,
    SUM(f.quantity) AS total_quantity_sold,
    ROUND(AVG(f.sales_amount), 2) AS average_order_value
FROM gold.fact_sales AS f
INNER JOIN gold.dim_customers AS c
    ON f.customer_key = c.customer_key
GROUP BY
    c.country
ORDER BY
    total_revenue DESC;
