#LEVEL 1
#Exercise 1
CREATE TABLE IF NOT EXISTS credit_card (
     id VARCHAR(20) PRIMARY KEY,
     iban VARCHAR(50) ,
     pan VARCHAR(19),
     pin VARCHAR(4),
     cvv INT,
     expiring_date VARCHAR(20)
     );


ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_credit_card
FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);  



#Exercise 2:
SELECT credit_card.id,
       iban
FROM credit_card
WHERE credit_card.id = 'CcU-2938';

UPDATE credit_card SET iban = 'TR323456312213576817699999' WHERE credit_card.id = 'CcU-2938';  


#Exercise 3:
#INSERT INTO transaction (id,credit_card_id,company_id,user_id,lat,longitude,amount,timestamp,declined) VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD','CcU-9999','b-9999','9999','829.999','-117.999',current_timestamp,'111.11','0');
#This code gave an error that's why I needed to insert company_id and credit_card_id to tables.
INSERT INTO credit_card (id) VALUES ('CcU-9999');
INSERT INTO company (id) VALUES ('b-9999');
INSERT INTO transaction (id,credit_card_id,company_id,user_id,lat,longitude,amount,timestamp,declined) 
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD','CcU-9999','b-9999','9999','829.999','-117.999','111.11',current_timestamp,'0');


#Exercise 4:
ALTER TABLE credit_card DROP COLUMN pan;

#LEVEL 2
#Exercise 1:
DELETE FROM transaction WHERE transaction.id= '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD';

SELECT *
FROM transaction
WHERE transaction.id= '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD'; 

#Exercise 2:
CREATE VIEW marketing_view AS
SELECT c.company_name,
       c.phone,
       c.country,
       AVG(t.amount) AS avg_sales
FROM company c
INNER JOIN transaction t  
ON c.id = t.company_id
GROUP BY c.company_name,c.phone,c.country;
 

SELECT *
FROM marketing_view
ORDER BY avg_sales DESC;  

#Exercise 3:
SELECT *
FROM marketing_view
WHERE country = 'Germany';

#LEVEL 3
#Exercise 1:
CREATE TABLE IF NOT EXISTS user (
	id CHAR(10) PRIMARY KEY,
	name VARCHAR(100),
	surname VARCHAR(100),
	phone VARCHAR(150),
	email VARCHAR(150),
	birth_date VARCHAR(100),
	country VARCHAR(150),
	city VARCHAR(150),
	postal_code VARCHAR(100),
	address VARCHAR(255)    
);


INSERT INTO user(id) VALUES('9999');

ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_user
FOREIGN KEY (user_id) REFERENCES user(id);




#Change the name of the table user to data_user and the data type of id column:
RENAME TABLE user to data_user;
ALTER TABLE data_user
MODIFY COLUMN id INT;

#Add the fecha_actual column to the credit_card table:
ALTER TABLE credit_card ADD fecha_actual DATE;


#Delete the website column from the company table :
ALTER TABLE company DROP COLUMN website;


#In the data_user table  change the name of email to personel_email
ALTER TABLE data_user CHANGE email personal_email VARCHAR(150);



#To establish the relationship between the transaction table and the data_user table, we need to use a foreign key constraint on user_id:
ALTER TABLE transaction
DROP FOREIGN KEY fk_transaction_user;

ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_data_user 
FOREIGN KEY (user_id) REFERENCES data_user(id);



#Exercise 2:
#Create a view called technical report:
CREATE VIEW technical_report AS
SELECT t.id AS transaction_id,
       d.name AS user_name,
       d.surname AS user_surname,
       cc.iban,
       c.company_name
FROM transaction t
INNER JOIN data_user d
ON t.user_id = d.id
INNER JOIN company c
ON t.company_id = c.id
INNER JOIN credit_card cc
ON t.credit_card_id = cc.id
GROUP BY transaction_id,user_name,user_surname,cc.iban,c.company_name;

#Displays the results of the view, sorts the results downward based on the transaction ID variable
SELECT *,
	   ROW_NUMBER() OVER (ORDER BY transaction_id DESC) AS row_num
FROM technical_report;       


















   