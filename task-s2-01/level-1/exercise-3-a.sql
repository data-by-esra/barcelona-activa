SELECT *
FROM transaction
WHERE company_id IN 
    (SELECT id
    FROM company
    WHERE country = 'Germany');
