/*
===============================================================================
Business Insight 6: Customer Purchase Frequency Ranking
===============================================================================

Business Question:
    Which customers place orders most frequently?

Business Value:
    Understanding customer purchase frequency helps the business:
        • Identify loyal and highly engaged customers.
        • Design targeted loyalty and retention programs.
        • Recognize customers with strong repeat purchasing behavior.
        • Improve customer relationship management (CRM) strategies.

SQL Concepts Used:
    • INNER JOIN
    • GROUP BY
    • Aggregate Functions (COUNT, SUM)
    • DENSE_RANK() Window Function
    • ORDER BY

Expected Power BI Visualization:
    • Horizontal Bar Chart
    • Table with Conditional Formatting

===============================================================================
*/

WITH customer_purchase_summary AS
(
    SELECT
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.country,
        COUNT(DISTINCT f.order_number) AS total_orders,
        SUM(f.sales_amount) AS total_revenue
    FROM gold.fact_sales AS f
    INNER JOIN gold.dim_customers AS c
        ON f.customer_key = c.customer_key
    GROUP BY
        c.customer_key,
        c.customer_number,
        c.first_name,
        c.last_name,
        c.country
)

SELECT
    DENSE_RANK() OVER (ORDER BY total_orders DESC) AS purchase_rank,
    customer_key,
    customer_number,
    customer_name,
    country,
    total_orders,
    total_revenue
FROM customer_purchase_summary
ORDER BY
    purchase_rank,
    total_revenue DESC;
