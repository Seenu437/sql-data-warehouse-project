/*
===============================================================================
Business Insight 5: Monthly Sales Trend Analysis
===============================================================================

Business Question:
    How have sales performed over time on a monthly basis?

Business Value:
    Analyzing monthly sales trends helps the business:
        • Identify seasonal sales patterns.
        • Monitor business growth over time.
        • Detect periods of declining performance.
        • Support forecasting and strategic planning.

SQL Concepts Used:
    • INNER JOIN
    • GROUP BY
    • Aggregate Functions (SUM, COUNT)
    • YEAR()
    • MONTH()
    • ORDER BY

Expected Power BI Visualization:
    • Line Chart
    • Area Chart

===============================================================================
*/

SELECT
    YEAR(f.order_date) AS sales_year,
    MONTH(f.order_date) AS sales_month,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales AS f
GROUP BY
    YEAR(f.order_date),
    MONTH(f.order_date)
ORDER BY
    sales_year,
    sales_month;
