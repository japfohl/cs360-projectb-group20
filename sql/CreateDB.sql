/*  
** Author: Collin James, CS 361
** Date: 2/26/17
** Description: Database test; run the following in mysql to create OR reset:
sudo mysql
source Test.sql;
*/

set foreign_key_checks = 0; -- force drop
DROP TABLE IF EXISTS `products`;
set foreign_key_checks = 1;


CREATE TABLE IF NOT EXISTS products (
	product_id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	photo_url VARCHAR(255) NOT NULL,
	PRIMARY KEY (product_id),
	CONSTRAINT uniq_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- -- test product
INSERT INTO products(name, photo_url) 
VALUES ('Pocky Biscuit Stick 5 Flavor Variety Pack (Pack of 5)','https://images-na.ssl-images-amazon.com/images/I/71QzLsqscXL._SX522_.jpg'),
('Wedderspoon 100% Raw Premium Manuka Honey KFactor 16+, 17.6 oz','https://images-na.ssl-images-amazon.com/images/I/61vlQw5CTIL._SY679_.jpg');