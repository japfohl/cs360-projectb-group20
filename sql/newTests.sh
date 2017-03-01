#!/bin/bash

myVar4=`sudo mysql -N -e 'use c9; DELETE FROM products WHERE name LIKE "%Pocky%";'`
myVar5=`sudo mysql -N -e 'use c9; DELETE FROM products WHERE name LIKE "%Wedderspoon%";'`
myVar1=`sudo mysql -N -e 'use c9; INSERT INTO products(name, photo_url) VALUES ("Pocky Biscuit Stick 5 Flavor Variety Pack (Pack of 5)","https://images-na.ssl-images-amazon.com/images/I/71QzLsqscXL._SX522_.jpg"), ("Wedderspoon 100% Raw Premium Manuka Honey KFactor 16+, 17.6 oz","https://images-na.ssl-images-amazon.com/images/I/61vlQw5CTIL._SY679_.jpg");'`

myVar2=`sudo mysql -N -e 'use c9; SELECT COUNT(*) FROM products;'`
echo "Product Count is " ${myVar2}


myVar3=`sudo mysql -N -e 'use c9; SELECT * FROM products WHERE name LIKE "%Pocky%";'`
echo "Pocky match is:"
echo "	" ${myVar3}
