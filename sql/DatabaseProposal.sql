/*  
	** Author: Collin James, CS 340
	** Date: 5/23/16
	** Description: Activity: Final Project: Database Definition
*/
-- For part one of this assignment you are to make a database with the following specifications and run the following queries
-- Table creation queries should immedatley follow the drop table queries, this is to facilitate testing on my end

set foreign_key_checks = 0; -- force drop
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `list`;
DROP TABLE IF EXISTS `list_product`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `manufacturer`;
DROP TABLE IF EXISTS `stores`;
DROP TABLE IF EXISTS `mfct_product`;
DROP TABLE IF EXISTS `product_store`;
set foreign_key_checks = 1;


CREATE TABLE IF NOT EXISTS users (
	user_id INT NOT NULL AUTO_INCREMENT,
	fname VARCHAR(255) NOT NULL,
	lname VARCHAR(255) NOT NULL,
	dob DATE,
	PRIMARY KEY (user_id),
	CONSTRAINT first_last_dob UNIQUE (fname,lname,dob)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS list (
	list_id INT NOT NULL AUTO_INCREMENT,
	created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- auto-initialized
	-- updated TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- okay in mysql ^5.6.4
	updated TIMESTAMP,
	fk_user_id INT NOT NULL,
	PRIMARY KEY (list_id),
	CONSTRAINT fk_user_id FOREIGN KEY (fk_user_id) 
		REFERENCES users (user_id)
		ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS product (
	product_id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	photo_url VARCHAR(255) NOT NULL,
	PRIMARY KEY (product_id),
	CONSTRAINT uniq_name UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS list_product (
	fk_product_id INT NOT NULL,
	fk_list_id INT NOT NULL,
	bought BOOLEAN NOT NULL DEFAULT 0, -- synonym for TINYINT
	PRIMARY KEY (fk_product_id, fk_list_id),
	CONSTRAINT fk_product_id FOREIGN KEY (fk_product_id) 
		REFERENCES product (product_id)
		ON DELETE CASCADE,
	CONSTRAINT fk_list_id_2 FOREIGN KEY (fk_list_id) 
	REFERENCES list (list_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS manufacturer (
	mfct_id INT NOT NULL AUTO_INCREMENT,
	country VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (mfct_id),
	CONSTRAINT country_name UNIQUE (country,name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS mfct_product (
	fk_product_id INT NOT NULL,
	fk_mfct_id INT,
	PRIMARY KEY (fk_product_id, fk_mfct_id),
	CONSTRAINT fk_product_id_2 FOREIGN KEY (fk_product_id) 
		REFERENCES product (product_id)
		ON DELETE CASCADE,
	CONSTRAINT fk_mfct_id FOREIGN KEY (fk_mfct_id) 
		REFERENCES manufacturer (mfct_id)
		ON DELETE CASCADE,
	CONSTRAINT unique_pid UNIQUE (fk_product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS stores (
	store_id INT NOT NULL AUTO_INCREMENT,
	store_url VARCHAR(255) NOT NULL,
	store_name VARCHAR(255) NOT NULL,
	PRIMARY KEY (store_id),
	CONSTRAINT url_name UNIQUE (store_url,store_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS product_store (
	fk_product_id INT NOT NULL,
	fk_store_id INT NOT NULL,
	price DECIMAL(7,2) NOT NULL,
	product_url VARCHAR(255) NOT NULL,
	PRIMARY KEY (fk_product_id, fk_store_id),
	CONSTRAINT fk_product_id_3 FOREIGN KEY (fk_product_id) 
		REFERENCES product (product_id)
		ON DELETE CASCADE,
	CONSTRAINT fk_store_id FOREIGN KEY (fk_store_id) 
		REFERENCES stores (store_id)
		ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- test users
INSERT INTO users(fname, lname, dob) 
VALUES ('Judicious','Roly','1970-01-02'),('Spartacus','Fraline','1979-11-18'),('Spankstock', 'Mortivale', '1985-03-02');
-- VALUES ('Judicious','Roly','1970-01-02');

-- -- test list (just add user_id and date)
INSERT INTO list(updated, fk_user_id) 
VALUES (CURRENT_TIMESTAMP, (SELECT u.user_id FROM users u WHERE u.fname = 'Judicious' and u.lname = 'Roly'));

INSERT INTO list(updated, fk_user_id) 
VALUES (CURRENT_TIMESTAMP, (SELECT u.user_id FROM users u WHERE u.fname = 'Spartacus' and u.lname = 'Fraline'));

INSERT INTO list(updated, fk_user_id) 
VALUES (CURRENT_TIMESTAMP, (SELECT u.user_id FROM users u WHERE u.fname = 'Spankstock' and u.lname = 'Mortivale'));

-- -- test product
INSERT INTO product(name, photo_url) 
VALUES ('Flowtron BK-15D Electronic Insect Killer, 1/2 Acre Coverage','http://ecx.images-amazon.com/images/I/715ZROmiT0L._SY550_.jpg');
INSERT INTO product(name, photo_url) 
VALUES ('Yimby Tumbler Composter, Color Black', 'http://ecx.images-amazon.com/images/I/71rKqDcllzL._SL1000_.jpg');
INSERT INTO product(name, photo_url) 
VALUES ('Coleman Cable 02356-05 40-Foot 16/3 Vinyl Landscape Outdoor Extension Cord, Green', 'http://ecx.images-amazon.com/images/I/71J7X6HYGUL._SL1500_.jpg');

-- test list_product (insert without ID, only names)
INSERT INTO list_product(fk_product_id, fk_list_id)
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Flowtron BK-15D Electronic Insect Killer, 1/2 Acre Coverage'), 
	(SELECT list_id FROM list l 
		INNER JOIN users u ON u.user_id = l.fk_user_id
		WHERE user_id = (SELECT user_id FROM users WHERE fname = 'Judicious' and lname = 'Roly'))
	);

INSERT INTO list_product(fk_product_id, fk_list_id)
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Yimby Tumbler Composter, Color Black'), 
	(SELECT list_id FROM list l 
		INNER JOIN users u ON u.user_id = l.fk_user_id
		WHERE user_id = (SELECT user_id FROM users WHERE fname = 'Spartacus' and lname = 'Fraline'))
	);

INSERT INTO list_product(fk_product_id, fk_list_id)
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Coleman Cable 02356-05 40-Foot 16/3 Vinyl Landscape Outdoor Extension Cord, Green'), 
	(SELECT list_id FROM list l 
		INNER JOIN users u ON u.user_id = l.fk_user_id
		WHERE user_id = (SELECT user_id FROM users WHERE fname = 'Spartacus' and lname = 'Fraline'))
	);

INSERT INTO list_product(fk_product_id, fk_list_id)
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Coleman Cable 02356-05 40-Foot 16/3 Vinyl Landscape Outdoor Extension Cord, Green'), 
	(SELECT list_id FROM list l 
		INNER JOIN users u ON u.user_id = l.fk_user_id
		WHERE user_id = (SELECT user_id FROM users WHERE fname = 'Spankstock' and lname = 'Mortivale'))
	);
-- test manufacturer:
INSERT INTO manufacturer(country, name)
VALUES ('USA','Coleman');

INSERT INTO manufacturer(name)
VALUES ('Flowtron');

INSERT INTO manufacturer(name)
VALUES ('Yimby');

-- test mfct_product (insert without ID, only names)
INSERT INTO mfct_product(fk_product_id, fk_mfct_id)
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Flowtron BK-15D Electronic Insect Killer, 1/2 Acre Coverage'), 
	(SELECT mfct_id FROM manufacturer m
	 WHERE m.name = 'Flowtron')
	);

INSERT INTO mfct_product(fk_product_id, fk_mfct_id)
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Coleman Cable 02356-05 40-Foot 16/3 Vinyl Landscape Outdoor Extension Cord, Green'), 
	(SELECT mfct_id FROM manufacturer m
	 WHERE m.name = 'Coleman' and m.country = 'USA')
	);

INSERT INTO mfct_product(fk_product_id, fk_mfct_id)
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Yimby Tumbler Composter, Color Black'), 
	(SELECT mfct_id FROM manufacturer m
	 WHERE m.name = 'Yimby')
	);

-- test stores
INSERT INTO stores(store_url, store_name)
VALUES ('http://www.amazon.com', 'Amazon');


-- test product_store
INSERT INTO product_store
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Flowtron BK-15D Electronic Insect Killer, 1/2 Acre Coverage'), (SELECT store_id FROM stores s WHERE s.store_name = 'Amazon'), 35.57, 'http://www.amazon.com/Flowtron-BK-15D-Electronic-Insect-Coverage/dp/B00004R9VZ/ref=sr_1_1');

INSERT INTO product_store
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Coleman Cable 02356-05 40-Foot 16/3 Vinyl Landscape Outdoor Extension Cord, Green'), (SELECT store_id FROM stores s WHERE s.store_name = 'Amazon'), 13.49, 'http://www.amazon.com/Coleman-Cable-02356-05-Landscape-Extension/dp/B00004SQET/ref=pd_sim_86_6');

INSERT INTO product_store
VALUES ((SELECT product_id FROM product p WHERE p.name = 'Yimby Tumbler Composter, Color Black'), (SELECT store_id FROM stores s WHERE s.store_name = 'Amazon'), 91.00, 'http://www.amazon.com/Yimby-Tumbler-Composter-Color-Black/dp/B009378AG2/ref=sr_1_1');