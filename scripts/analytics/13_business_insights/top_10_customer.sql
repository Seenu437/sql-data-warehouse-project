/*
===============================================================================
Business Insight 1: Top 10 Customers by Revenue
===============================================================================

Business Question:
    Who are the top 10 customers based on total revenue generated?

Business Value:
    Identifying the highest-value customers enables the business to:
        • Develop loyalty and retention programs.
        • Offer personalized promotions.
        • Strengthen relationships with VIP customers.
        • Increase Customer Lifetime Value (CLV).

SQL Concepts Used:
    • INNER JOIN
    • GROUP BY
    • Aggregate Functions (SUM)
    • ORDER BY
    • TOP

Expected Power BI Visualization:
    • Horizontal Bar Chart

===============================================================================
*/

SELECT TOP (10)
       c.customer_key,
       c.customer_number,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       c.country,
       SUM(f.sales_amount) AS total_revenue,
       COUNT(DISTINCT f.order_number) AS total_orders,
       SUM(f.quantity) AS total_quantity_purchased
FROM gold.fact_sales AS f
INNER JOIN gold.dim_customers AS c
        ON f.customer_key = c.customer_key
GROUP BY
       c.customer_key,
       c.customer_number,
       c.first_name,
       c.last_name,
       c.country
ORDER BY total_revenue DESC;
