create database banking;
use banking;

select * from bank_loan_cleaned blc;


# Over all rate
SELECT 
    COUNT(*) AS total_customers,
    ROUND(100.0 * SUM(CASE WHEN `default`='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM bank_loan_cleaned;

# Loan type
SELECT loan_type,
    COUNT(*) AS total_loans,
    ROUND(100.0 * SUM(CASE WHEN `default`='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM bank_loan_cleaned
GROUP BY loan_type
ORDER BY default_rate_pct DESC;



# employe type
SELECT employment_type,
    COUNT(*) AS total_loans,
    ROUND(100.0 * SUM(CASE WHEN `default`='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM bank_loan_cleaned
GROUP BY employment_type
ORDER BY default_rate_pct DESC;


# Avg credit score and income
SELECT `default`,
    ROUND(AVG(credit_score), 1) AS avg_credit_score,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income
FROM bank_loan_cleaned
GROUP BY `default`;

# : Loan amount risk
SELECT 
    ROUND(SUM(CASE WHEN `default`='Yes' THEN loan_amount ELSE 0 END), 2) AS amount_at_risk,
    ROUND(SUM(loan_amount), 2) AS total_loan_amount,
    ROUND(100.0 * SUM(CASE WHEN `default`='Yes' THEN loan_amount ELSE 0 END) / SUM(loan_amount), 2) AS pct_at_risk
FROM bank_loan_cleaned;


# from last payment 
SELECT late_payments_last_year,
    COUNT(*) AS total_customers,
    ROUND(100.0 * SUM(CASE WHEN `default`='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM bank_loan_cleaned
GROUP BY late_payments_last_year
ORDER BY late_payments_last_year;



# bases on home ownership
SELECT home_ownership,
    COUNT(*) AS total_customers,
    ROUND(100.0 * SUM(CASE WHEN `default`='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM bank_loan_cleaned
GROUP BY home_ownership
ORDER BY default_rate_pct DESC;



# Top 10 highest loan amount defaulters
SELECT customer_id, loan_type, loan_amount, credit_score, monthly_income
FROM bank_loan_cleaned
WHERE `default` = 'Yes'
ORDER BY loan_amount DESC
LIMIT 10;

# based on closed credit score
SELECT 
    CASE 
        WHEN credit_score < 500 THEN 'Poor (below 500)'
        WHEN credit_score BETWEEN 500 AND 650 THEN 'Fair (500-650)'
        WHEN credit_score BETWEEN 651 AND 750 THEN 'Good (651-750)'
        ELSE 'Excellent (750+)'
    END AS credit_score_band,
    COUNT(*) AS total_customers,
    ROUND(100.0 * SUM(CASE WHEN `default`='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM bank_loan_cleaned
GROUP BY credit_score_band
ORDER BY default_rate_pct DESC;



#Employment + Loan type combo
SELECT employment_type, loan_type,
    COUNT(*) AS total_customers,
    ROUND(100.0 * SUM(CASE WHEN `default`='Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS default_rate_pct
FROM bank_loan_cleaned
GROUP BY employment_type, loan_type
ORDER BY default_rate_pct DESC;






