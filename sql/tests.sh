#!/bin/bash

#- SHOW TABLES LIKE 'product'; -- come back to this later

sudo mysql <<EOF

use c9

INSERT INTO products(name, photo_url) 
VALUES ('Pocky Biscuit Stick 5 Flavor Variety Pack (Pack of 5)','https://images-na.ssl-images-amazon.com/images/I/71QzLsqscXL._SX522_.jpg'),
('Wedderspoon 100% Raw Premium Manuka Honey KFactor 16+, 17.6 oz','https://images-na.ssl-images-amazon.com/images/I/61vlQw5CTIL._SY679_.jpg');

EOF

sudo mysql <<EOF2
use c9;
SELECT COUNT FROM products;
EOF2

sudo mysql <<EOF3
use c9;
SELECT * FROM products WHERE name LIKE '%Pocky%';
EOF3
