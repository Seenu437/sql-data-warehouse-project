/*
===============================================================================
Business Insight 9: Inactive Customer Analysis
===============================================================================

Business Question:
    Which customers have not placed an order within the last 6 months
    of the available dataset?

Business Value:
    Identifying inactive customers enables the business to:
        • Detect customers at risk of churn.
        • Launch targeted re-engagement campaigns.
        • Improve customer retention.
        • Increase Customer Lifetime Value (CLV).

SQL Concepts Used:
    • INNER JOIN
    • Common Table Expression (CTE)
    • Aggregate Functions (MAX, SUM, COUNT)
    • CROSS JOIN
    • DATEDIFF
    • CASE Expression

Expected Power BI Visualization:
    • Table
    • KPI Card
    • Donut Chart

===============================================================================
*/

WITH customer_activity AS
(
    SELECT
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name,' ',c.last_name) AS customer_name,
        c.country,
        MAX(f.order_date) AS last_order_date,
        COUNT(DISTINCT f.order_number) AS total_orders,
        SUM(f.sales_amount) AS total_revenue
    FROM gold.fact_sales f
    INNER JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY
        c.customer_key,
        c.customer_number,
        c.first_name,
        c.last_name,
        c.country
),

latest_order AS
(
    SELECT
        MAX(order_date) AS latest_order_date
    FROM gold.fact_sales
)

SELECT
    ca.customer_key,
    ca.customer_number,
    ca.customer_name,
    ca.country,
    ca.last_order_date,
    DATEDIFF(MONTH,
             ca.last_order_date,
             lo.latest_order_date) AS months_inactive,
    ca.total_orders,
    ca.total_revenue,

    CASE
        WHEN DATEDIFF(MONTH,
                      ca.last_order_date,
                      lo.latest_order_date) >= 12
            THEN 'High Risk'

        WHEN DATEDIFF(MONTH,
                      ca.last_order_date,
                      lo.latest_order_date) >= 6
            THEN 'Medium Risk'

        ELSE 'Active'
    END AS customer_status

FROM customer_activity ca
CROSS JOIN latest_order lo

ORDER BY
    months_inactive DESC,
    total_revenue DESC;
