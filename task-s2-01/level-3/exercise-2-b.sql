SELECT c.company_name,
       COUNT(t.id) AS transaction_count
FROM company AS c
LEFT JOIN transaction AS t
ON c.id = t.company_id
GROUP BY c.company_name
HAVING COUNT(t.id) <= 400
ORDER BY transaction_count DESC;