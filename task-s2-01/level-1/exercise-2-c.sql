SELECT c.company_name,
       AVG(t.amount) AS avg_sales
FROM transactions.transaction AS t
JOIN transactions.company AS c
ON t.company_id = c.company_id
GROUP BY c.company_name
ORDER BY avg_sales DESC
LIMIT 1;
