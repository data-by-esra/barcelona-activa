#Level 1
#Exercise 2

#List of countries that are generating sales.
SELECT DISTINCT country
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
ORDER BY country;


#From how many countries sales are generated.
SELECT COUNT(DISTINCT country) AS countries
FROM company AS c
JOIN transaction AS t
ON c.id =t.company_id;


#It identifies the company with the highest average sales.
SELECT c.company_name, 
       AVG(t.amount) AS avg_sales
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
GROUP BY t.company_id
ORDER BY avg_sales DESC
LIMIT 1;

#Exercise 3

#Displays all transactions made by companies in Germany.
SELECT *
FROM transaction
WHERE company_id IN 
    (SELECT id
    FROM company
    WHERE country = 'Germany');
    
    
    
#List the companies that have made transactions for a higher amount than the average of all transactions.
SELECT DISTINCT company_name
FROM company
WHERE id IN
    (SELECT company_id
     FROM transaction
     WHERE amount > (SELECT AVG(amount)
                     FROM transaction)
    ); 
    
    
    
#They will remove from the system the companies that do not have registered transactions, deliver the list of these companies.    
SELECT *
FROM company
WHERE id NOT IN 
    (SELECT DISTINCT company_id
     FROM transaction
     WHERE company_id IS NOT NULL
    );

#LEVEL 2    
#Exercise 1 
#It identifies the five days that the largest amoungt of income was generated in the company
#by sales.Display the date of each transaction along with the total sales.
SELECT c.company_name,
    DATE(t.timestamp) AS transaction_date,
    SUM(t.amount) AS total_sale
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
GROUP BY DATE (t.timestamp), c.company_name
ORDER BY total_sale DESC
LIMIT 5;


#Exercise 2
#What is the average sales per country? It presents the results ordered from highest to lowest average.
SELECT DISTINCT c.country,
       AVG(t.amount) AS avg_sales
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
GROUP BY c.country
ORDER BY avg_sales DESC;

#Exercise 3
#They ask you for the list of all the transactions carried out by companies that are located in the same country as this company.
#Display the list by applying JOIN and subconsults.

SELECT *
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
WHERE c.country = (
    SELECT country
    FROM company
    WHERE company_name = 'Non Institute'
    );
    
# Display the list by applying only subconsults
SELECT *
FROM transaction
WHERE company_id IN 
    (SELECT id
     FROM company
     WHERE country = 
            (SELECT country
            FROM company
            WHERE company_name = 'Non Institute'
            )
    );  
    
#Level 3
#Exercise 1
#It presents the name,telephone,country,date and amopunt of those companies taht made transaction with a value between 350
#and 400 euros and on any of these dates:April 29,2015,July 20,2018 and March 13,2024.Sort results from highest to lowest quantity.

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
ORDER BY t.amount DESC; 

#Exercise 2
#A list of companies where you specify if they have more than 400 transactions or less.

SELECT c.company_name,
       COUNT(t.id) AS transaction_count,
       CASE
           WHEN COUNT(t.id) > 400 THEN 'More than 400'
           ELSE '400 or less'
       END AS transaction_result
 FROM company AS c
 JOIN transaction AS t
 ON c.id = t.company_id
 GROUP BY c.id,c.company_name
 ORDER BY transaction_count DESC;

