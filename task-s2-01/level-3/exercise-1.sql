SELECT c.company_name,
       c.phone,
       c.country,
       t.amount AS amount,
       DATE(t.timestamp) AS transaction_date
FROM transaction AS t
JOIN company AS c
ON t.company_id = c.id
WHERE amount BETWEEN 350 AND 400
      AND DATE(t.timestamp) IN ('2015-04-29', '2018-07-20','2024-03-13')
ORDER BY amount DESC;     