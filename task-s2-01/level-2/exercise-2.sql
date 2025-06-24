SELECT DISTINCT c.country,
       AVG(t.amount) AS avg_sales
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
GROUP BY c.country
ORDER BY avg_sales DESC;