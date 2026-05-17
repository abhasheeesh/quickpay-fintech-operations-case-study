-- Q1
-- Count transactions by status

SELECT
    status,
    COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status;



-- Q2
-- Calculate total captured GMV by merchant

SELECT
    merchant_name,
    SUM(amount_usd) AS captured_gmv
FROM cleaned_transactions
WHERE status = 'success'
GROUP BY merchant_name
ORDER BY captured_gmv DESC;



-- Q3
-- Top 10 merchants by captured GMV

SELECT
    merchant_name,
    SUM(
        CASE
            WHEN status = 'success' THEN amount_usd
            ELSE 0
        END
    ) AS captured_gmv
FROM cleaned_transactions
GROUP BY merchant_name
ORDER BY captured_gmv DESC
LIMIT 10;



-- Q4
-- Daily GMV and successful transaction count

SELECT
    transaction_date,
    SUM(amount_usd) AS total_gmv,
    COUNT(
        CASE
            WHEN status = 'success' THEN 1
        END
    ) AS successful_transactions
FROM cleaned_transactions
GROUP BY transaction_date
ORDER BY transaction_date;



-- Q5
-- Merchants with chargeback ratio above 1%

SELECT
    merchant_name,
    COUNT(
        CASE
            WHEN status = 'chargeback' THEN 1
        END
    ) * 100.0 / COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name
HAVING chargeback_ratio > 1
ORDER BY chargeback_ratio DESC;



-- Q6
-- Regions with average risk score above 50 and more than 20 transactions

SELECT
    gateway_region,
    COUNT(*) AS total_transactions,
    AVG(risk_score) AS avg_risk_score
FROM cleaned_transactions
WHERE gateway_region IS NOT NULL
AND gateway_region != 'N/A'
GROUP BY gateway_region
HAVING avg_risk_score > 50
AND total_transactions > 20
ORDER BY avg_risk_score DESC;



-- Q7
-- Users with 3 or more failed or chargeback transactions on the same day

SELECT
    user_id,
    transaction_date,
    COUNT(*) AS risky_transactions
FROM cleaned_transactions
WHERE status IN ('failed', 'chargeback')
GROUP BY user_id, transaction_date
HAVING risky_transactions >= 3
ORDER BY risky_transactions DESC;



-- Q8
-- Chargeback count, unique affected users, and chargeback amount by merchant

SELECT
    merchant_name,
    COUNT(*) AS chargeback_count,
    COUNT(DISTINCT user_id) AS affected_users,
    SUM(amount_usd) AS total_chargeback_amount
FROM cleaned_transactions
WHERE status = 'chargeback'
GROUP BY merchant_name
ORDER BY total_chargeback_amount DESC;