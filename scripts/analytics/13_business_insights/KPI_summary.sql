/*
===============================================================================
Business Insight 10: Executive KPI Summary Dashboard
===============================================================================

Business Question:
    What are the key performance indicators (KPIs) that summarize the overall
    business performance?

Business Value:
    This executive summary provides decision-makers with a quick overview of
    business performance by consolidating essential KPIs into a single report.
    These metrics can be used to monitor business health and support
    strategic decision-making.

SQL Concepts Used:
    • Aggregate Functions (SUM, COUNT, AVG, MIN, MAX)
    • Scalar Subqueries
    • ROUND
    • DISTINCT

Expected Power BI Visualization:
    • KPI Cards
    • Gauge Charts
    • Executive Dashboard

===============================================================================
*/

SELECT

    /* Sales KPIs */

    SUM(sales_amount) AS total_revenue,

    COUNT(DISTINCT order_number) AS total_orders,

    SUM(quantity) AS total_quantity_sold,

    ROUND(AVG(sales_amount),2) AS average_order_value,

    /* Customer KPIs */

    (SELECT COUNT(*)
     FROM gold.dim_customers) AS total_customers,

    /* Product KPIs */

    (SELECT COUNT(*)
     FROM gold.dim_products) AS total_products,

    (SELECT COUNT(DISTINCT category)
     FROM gold.dim_products) AS total_categories,

    (SELECT COUNT(DISTINCT subcategory)
     FROM gold.dim_products) AS total_subcategories,

    /* Country KPI */

    (SELECT COUNT(DISTINCT country)
     FROM gold.dim_customers) AS countries_served,

    /* Date Range */

    MIN(order_date) AS first_order_date,

    MAX(order_date) AS latest_order_date

FROM gold.fact_sales;
