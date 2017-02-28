/*  
** Author: Collin James, CS 361
** Date: 2/26/17
** Description: Database test
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
INSERT INTO product(name, photo_url) 
VALUES ('Flowtron BK-15D Electronic Insect Killer, 1/2 Acre Coverage','http://ecx.images-amazon.com/images/I/715ZROmiT0L._SY550_.jpg');