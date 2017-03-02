#!/bin/bash

# Delete test data just in case
sudo mysql -N -e 'use c9; DELETE FROM products WHERE name LIKE "%Pocky%";'
sudo mysql -N -e 'use c9; DELETE FROM products WHERE name LIKE "%Wedderspoon%";'
# Insert good data
myVar1=`sudo mysql -N -e 'use c9; INSERT INTO products(name, realcost, photo_url) VALUES 
("Pocky Biscuit Stick 5 Flavor Variety Pack (Pack of 5)", "5.99","https://images-na.ssl-images-amazon.com/images/I/71QzLsqscXL._SX522_.jpg"), 
("Wedderspoon 100% Raw Premium Manuka Honey KFactor 16+, 17.6 oz", "19.95", "https://images-na.ssl-images-amazon.com/images/I/61vlQw5CTIL._SY679_.jpg");'`

# Test that the insertion worked
myVar2=`sudo mysql -N -e 'use c9; SELECT COUNT(*) FROM products;'`
if [ ${myVar2} != 2 ]; then
    echo -n "Test FAILED, "
else
    echo -n "             "
fi
echo "product count after insertion is " ${myVar2}


myVar3=`sudo mysql -N -e 'use c9; SELECT * FROM products WHERE name LIKE "%Pocky%";'`
if [ "${myVar3}x" = "x" ]; then
    echo -n "Test FAILED, "
else
    echo -n "             "
fi
echo "Pocky match is:" ${myVar3}

myVar6=`sudo mysql -N -e 'use c9; SELECT * FROM products WHERE name LIKE "%NotExist%";'`
if [ "${myVar6}x" = "x" ]; then
    echo -n "             "
else
    echo -n "Test FAILED, "  # Should not match!
fi
echo "NotExist match is:" ${myVar6}

# Test constraints - 
#   Unique name
#   can't be null values
# Test delete cascades
# Test manufacturer




sudo mysql -N -e 'use c9; DELETE FROM products WHERE name LIKE "%Pocky%";'
sudo mysql -N -e 'use c9; DELETE FROM products WHERE name LIKE "%Wedderspoon%";'