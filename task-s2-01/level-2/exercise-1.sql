SELECT c.company_name,
    DATE(t.timestamp) AS transaction_date,
    SUM(t.amount) AS total_sale
FROM transavtion AS t
JOIN company AS c
ON t.company_id = c.id
GROUP BY DATE (t.timestamp), c.company_name
ORDER BY total_sale DESC
LIMIT 5;
