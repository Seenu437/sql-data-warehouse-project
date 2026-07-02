/*
===============================================================================
Business Insight 8: Month-over-Month (MoM) Sales Growth Analysis
===============================================================================

Business Question:
    How has monthly revenue changed compared to the previous month?

Business Value:
    Month-over-Month (MoM) analysis helps the business:
        • Monitor business growth trends.
        • Identify periods of rapid growth or decline.
        • Evaluate the impact of promotions or seasonal demand.
        • Support forecasting and strategic planning.

SQL Concepts Used:
    • Common Table Expression (CTE)
    • Aggregate Functions (SUM)
    • Window Function (LAG)
    • Date Functions (YEAR, MONTH)
    • CASE Expression
    • ROUND

Expected Power BI Visualization:
    • Line Chart
    • Clustered Column Chart

===============================================================================
*/

WITH monthly_sales AS
(
    SELECT
        YEAR(order_date) AS sales_year,
        MONTH(order_date) AS sales_month,
        SUM(sales_amount) AS total_revenue
    FROM gold.fact_sales
    GROUP BY
        YEAR(order_date),
        MONTH(order_date)
)

SELECT
    sales_year,
    sales_month,
    total_revenue,

    LAG(total_revenue) OVER
    (
        ORDER BY sales_year, sales_month
    ) AS previous_month_revenue,

    total_revenue -
    LAG(total_revenue) OVER
    (
        ORDER BY sales_year, sales_month
    ) AS revenue_difference,

    ROUND(
        (
            (total_revenue -
            LAG(total_revenue) OVER
            (
                ORDER BY sales_year, sales_month
            ))
            /
            LAG(total_revenue) OVER
            (
                ORDER BY sales_year, sales_month
            )
        ) * 100,
        2
    ) AS growth_percentage

FROM monthly_sales
ORDER BY
    sales_year,
    sales_month;
