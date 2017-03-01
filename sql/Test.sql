/*  
** Author: Collin James, CS 361
** Date: 2/26/17
** Description: Database test; run the following in mysql to create OR reset:
sudo mysql
source Test.sql;
*/


-- -- test product

-- SHOW TABLES LIKE 'product'; -- come back to this later

INSERT INTO products(name, photo_url) 
VALUES ('Pocky Biscuit Stick 5 Flavor Variety Pack (Pack of 5)','https://images-na.ssl-images-amazon.com/images/I/71QzLsqscXL._SX522_.jpg'),
('Wedderspoon 100% Raw Premium Manuka Honey KFactor 16+, 17.6 oz','https://images-na.ssl-images-amazon.com/images/I/61vlQw5CTIL._SY679_.jpg');

SELECT COUNT (*) FROM products;

SELECT * FROM PRODUCTS WHERE name LIKE '%Pocky%';