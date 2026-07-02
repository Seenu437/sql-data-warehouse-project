/*
===============================================================================
Business Insight 7: Customer Segmentation by Revenue
===============================================================================

Business Question:
    How can customers be segmented based on their total spending?

Business Value:
    Customer segmentation enables the business to:
        • Identify high-value customers (VIP).
        • Develop personalized marketing campaigns.
        • Improve customer retention strategies.
        • Allocate sales resources more effectively.

SQL Concepts Used:
    • Common Table Expression (CTE)
    • Aggregate Functions (SUM, COUNT)
    • CASE Expression
    • INNER JOIN
    • GROUP BY
    • ORDER BY

Expected Power BI Visualization:
    • Donut Chart
    • Stacked Column Chart

===============================================================================
*/

WITH customer_summary AS
(
    SELECT
        c.customer_key,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.country,
        SUM(f.sales_amount) AS total_revenue,
        COUNT(DISTINCT f.order_number) AS total_orders
    FROM gold.fact_sales AS f
    INNER JOIN gold.dim_customers AS c
        ON f.customer_key = c.customer_key
    GROUP BY
        c.customer_key,
        c.first_name,
        c.last_name,
        c.country
)

SELECT
    customer_key,
    customer_name,
    country,
    total_orders,
    total_revenue,

    CASE
        WHEN total_revenue >= 100000 THEN 'VIP Customer'
        WHEN total_revenue >= 50000 THEN 'High Value Customer'
        WHEN total_revenue >= 10000 THEN 'Medium Value Customer'
        ELSE 'Low Value Customer'
    END AS customer_segment

FROM customer_summary
ORDER BY total_revenue DESC;
