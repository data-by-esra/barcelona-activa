SELECT t.*
FROM transaction AS t
JOIN company AS c
ON t.company_id = c.id
WHERE c.country = (
    SELECT country
    FROM company
    WHERE company_name = 'Non Institude''
    );