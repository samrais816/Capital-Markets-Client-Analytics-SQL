-- ====================================================================
-- Capital Markets Analytical Queries
-- Focus: Business Intelligence, Client Profitability, Risk, and Trends
-- ====================================================================

-- Query 1: Top 5 Most Profitable Clients
-- Goal: Identify clients generating the highest total commission revenue.
SELECT 
    c.client_id,
    c.client_name,
    c.segment,
    c.relationship_manager,
    COUNT(t.trade_id) AS total_trades,
    SUM(t.notional_amount) AS total_volume_traded,
    SUM(t.commission_revenue) AS total_commission_revenue
FROM clients c
JOIN trades t ON c.client_id = t.client_id
GROUP BY c.client_id, c.client_name, c.segment, c.relationship_manager
ORDER BY total_commission_revenue DESC
LIMIT 5;

-- Query 2: Trading Desk Revenue & Average Risk Profile
-- Goal: Compare revenue performance against risk across trading desks.
SELECT 
    d.desk_name,
    d.head_trader,
    COUNT(t.trade_id) AS trade_count,
    SUM(t.commission_revenue) AS total_desk_revenue,
    ROUND(AVG(t.risk_score), 2) AS avg_risk_score
FROM desks d
JOIN trades t ON d.desk_id = t.desk_id
GROUP BY d.desk_name, d.head_trader
ORDER BY total_desk_revenue DESC;

-- Query 3: Ranking Clients Within Each Market Segment
-- Goal: Rank clients inside their respective segment (Hedge Fund, Institutional, Corporate).
WITH ClientRevenue AS (
    SELECT 
        c.client_name,
        c.segment,
        SUM(t.commission_revenue) AS total_revenue
    FROM clients c
    JOIN trades t ON c.client_id = t.client_id
    GROUP BY c.client_name, c.segment
)
SELECT 
    client_name,
    segment,
    total_revenue,
    DENSE_RANK() OVER (PARTITION BY segment ORDER BY total_revenue DESC) AS segment_rank
FROM ClientRevenue
ORDER BY segment, segment_rank;

-- Query 4: Client Concentration Risk Analysis (% Share of Bank Revenue)
-- Goal: Measure revenue concentration risk across client relationships.
WITH TotalRevenue AS (
    SELECT SUM(commission_revenue) AS overall_bank_revenue FROM trades
),
ClientRevenue AS (
    SELECT 
        c.client_name,
        SUM(t.commission_revenue) AS client_revenue
    FROM clients c
    JOIN trades t ON c.client_id = t.client_id
    GROUP BY c.client_name
)
SELECT 
    cr.client_name,
    cr.client_revenue,
    ROUND((cr.client_revenue / tr.overall_bank_revenue) * 100, 2) AS pct_of_total_revenue
FROM ClientRevenue cr
CROSS JOIN TotalRevenue tr
ORDER BY cr.client_revenue DESC;

-- Query 5: Month-over-Month Revenue & Volume Growth Trends
-- Goal: Calculate monthly growth using LAG window functions.
WITH MonthlySummary AS (
    SELECT 
        DATE_TRUNC('month', trade_date) AS month,
        SUM(commission_revenue) AS monthly_revenue,
        SUM(notional_amount) AS monthly_volume
    FROM trades
    GROUP BY DATE_TRUNC('month', trade_date)
)
SELECT 
    month,
    monthly_revenue,
    LAG(monthly_revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        ((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month)) / 
        NULLIF(LAG(monthly_revenue) OVER (ORDER BY month), 0)) * 100, 2
    ) AS mom_revenue_growth_pct
FROM MonthlySummary
ORDER BY month;

-- Query 6: High-Risk & Large Notional Trade Compliance Audit
-- Goal: Filter high-risk trades (risk_score >= 4, notional > $50M) for risk audit.
SELECT 
    t.trade_id,
    t.trade_date,
    c.client_name,
    d.desk_name,
    t.asset_class,
    t.notional_amount,
    t.commission_revenue,
    t.risk_score
FROM trades t
JOIN clients c ON t.client_id = c.client_id
JOIN desks d ON t.desk_id = d.desk_id
WHERE t.risk_score >= 4 
  AND t.notional_amount > 50000000.00
ORDER BY t.notional_amount DESC;
