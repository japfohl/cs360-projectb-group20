/*  
** Author: Collin James, CS 361
** Date: 2/26/17
** Description: Database test; run the following in mysql to create OR reset:
sudo mysql
source Test.sql;
*/

set foreign_key_checks = 0; -- force drop
DROP TABLE IF EXISTS `manufacturers_values`;
DROP TABLE IF EXISTS `users_values`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `values`;
DROP TABLE IF EXISTS `products`;
DROP TABLE IF EXISTS `manufacturers`;
set foreign_key_checks = 1;
/*
-- Notes from discussion
*  Need tables for product, manufacturer, user with one user in it
*  
*  Product: 
*    id, stringname, imageurl (optional), manufacturer, realcost
*  Manufacturer:
*    id, stringname,
*  Values:
*     id, stringname, "copy"
*  User:
*     id, stringname
*  User-Values
*  Manufacturer-Values
*
*/

CREATE TABLE IF NOT EXISTS manufacturers (
	man_id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (man_id),
	CONSTRAINT uniq_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS products (
	product_id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	photo_url VARCHAR(255) NOT NULL,
	manufacturer INT,
	realcost DECIMAL(10,2),
	PRIMARY KEY (product_id),
	CONSTRAINT man_key FOREIGN KEY fman_key (manufacturer)
		REFERENCES manufacturers (man_id)
		ON DELETE SET NULL,
	CONSTRAINT uniq_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS vals (
	val_id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	copy VARCHAR(2048),
	PRIMARY KEY (val_id),
	CONSTRAINT uniq_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS users (
	user_id INT NOT NULL AUTO_INCREMENT,
	firstname VARCHAR(255) NOT NULL,
	lastname VARCHAR(255) NOT NULL,
	username VARCHAR(32) NOT NULL,
	PRIMARY KEY (user_id),
	CONSTRAINT uniq_name UNIQUE(username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS users_values (
	fk_user_id INT NOT NULL,
	fk_value_id INT NOT NULL,
	PRIMARY KEY (fk_user_id, fk_value_id),
	CONSTRAINT user_id FOREIGN KEY fuser_id (fk_user_id) 
		REFERENCES users (user_id)
		ON DELETE CASCADE,
	CONSTRAINT value_id FOREIGN KEY fvalue_id (fk_value_id) 
		REFERENCES vals (val_id)
		ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS manufacturers_values (
	fk_mfct_id INT NOT NULL,
	fk_value_id INT NOT NULL,
	cost INT NOT NULL,
	PRIMARY KEY (fk_mfct_id, fk_value_id),
	CONSTRAINT mfct_id FOREIGN KEY fmfct_id (fk_mfct_id) 
		REFERENCES manufacturers (man_id)
		ON DELETE CASCADE,
	CONSTRAINT val_id FOREIGN KEY fval_id (fk_value_id) 
		REFERENCES vals (val_id)
		ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;