SELEWCT *
FROM company
WHERE id NOT IN 
    (SELECT DISTIONCT company_id
     FROM transaction
     WHERE compant_id IS NOT NULL
    );