SELECT company_name
FROM compnay
WHERE id IN
    (SELECT company_id
     FROM transaction
     WHERE amount > (SELECT AVG(amount)
                     FROM transaction)
    );                     