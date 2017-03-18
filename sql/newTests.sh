#!/bin/bash
sudo mysql -N -e 'create database c9_test;'
sudo mysql c9_test -N -e 'source CreateDB.sql;'

# Test that creation worked
tables=`sudo mysql -N -e 'SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = "c9";'`
if [ ${tables} != 6 ]; then
    echo -n "Test FAILED, "
else
    echo -n "   Creation succeeded, "
fi
echo "table count after insertion is "${tables}

sudo mysql c9_test -N -e 'source LoadDB.sql;'
# Delete test data just in case
sudo mysql -N -e 'use c9_test; DELETE FROM products WHERE name LIKE "%Pocky%";'
sudo mysql -N -e 'use c9_test; DELETE FROM products WHERE name LIKE "%Wedderspoon%";'

curCount=`sudo mysql -N -e 'use c9_test; SELECT COUNT(*) FROM products;'`
# Insert good data
myVar1=`sudo mysql -N -e 'use c9_test; INSERT INTO products(name, realcost, photo_url) VALUES 
("Pocky Biscuit Stick 5 Flavor Variety Pack (Pack of 5)", "5.99","https://images-na.ssl-images-amazon.com/images/I/71QzLsqscXL._SX522_.jpg"), 
("Wedderspoon 100% Raw Premium Manuka Honey KFactor 16+, 17.6 oz", "19.95", "https://images-na.ssl-images-amazon.com/images/I/61vlQw5CTIL._SY679_.jpg");'`

# Test that the insertion worked
newCount=`sudo mysql -N -e 'use c9_test; SELECT COUNT(*) FROM products;'`
myVar2=$((newCount - curCount))
if [ ${myVar2} != 2 ]; then
    echo -n "TEST FAIL "
else
    echo -n "       OK Insertion succeeded, "
fi
echo "product count after insertion is " ${myVar2}


myVar3=`sudo mysql -N -e 'use c9_test; SELECT * FROM products WHERE name LIKE "%Pocky%";'`
if [ "${myVar3}x" = "x" ]; then
    echo -n "Test FAILED, "
else
    echo -n "       OK Select test succeeded, "
fi
echo -n "Pocky match is:" 
echo ${myVar3} | sed -e 's/Stick.*$//'

myVar6=`sudo mysql -N -e 'use c9_test; SELECT * FROM products WHERE name LIKE "%NotExist%";'`
if [ "${myVar6}x" = "x" ]; then
    echo -n "       OK Select test of nonexistent item succeeded, "
else
    echo -n "Test FAILED, "  # Should not match!
fi
echo "NotExist match is:" ${myVar6}


# Test constraints - 
#   Unique name
myUniq=$( sudo mysql -N -e 'use c9_test; INSERT INTO products(name, realcost, photo_url) VALUES ("Pocky Biscuit Stick 5 Flavor Variety Pack (Pack of 5)", "5.99","url here");' 2>&1 )
if [ "${myUniq}x" = "x" ]; then
    echo  "Test FAILED, "  # Insertion should not succeed
else
    echo  "       OK Test of uniqueness constraint succeeded, "
fi
echo  "          >> Unique constraint error is:" ${myUniq}

#   can't be null values
myNullName=$( sudo mysql -N -e 'use c9_test; INSERT INTO products(name, realcost, photo_url) VALUES (NULL,"5.99","url here");' 2>&1 )
if [ "${myNullName}x" = "x" ]; then
    echo  "Test FAILED, "  # Should not succeed!
else
    echo  "       OK Test of non-null constraint succeeded, "
fi
echo  "          >> Not Null constraint error is:" ${myNullName}

# Test delete cascades

myChild=$( sudo mysql -N -e 'use c9_test; SELECT man_id FROM manufacturers mv WHERE (mv.name = "LG");' )
sudo mysql -N -e 'use c9_test; DELETE FROM manufacturers WHERE name = "LG";'

myCascade=$( sudo mysql -N -e 'use c9_test; SELECT * FROM manufacturers_values WHERE fk_mfct_id = '$myChild';' )

if [ "${myCascade}x" != "x" ]; then
    echo -n "Test FAILED, Child rows not deleted"  # 
else
    echo -n "       OK Cascade Delete succeeded!"
fi
echo $myCascade

# Get names of user values
myVals=$( sudo mysql -N -e 'use c9_test; select v.name from users_values uv INNER JOIN vals v ON uv.fk_value_id = v.val_id WHERE uv.fk_user_id=1;' 2>&1 )
clean=$(tr -cd '[:print:]' <<< $myVals)


if [ "${clean}x" = "x" ]; then
    echo -n "Test FAILED, No values returned"  # 
elif [ "${clean}" = "Fair Labor Sustainable US-Made" ]; then
    echo -n "       OK Values test succeeded, "
else
    # more tests here
    echo -n "    ???  Values returned unexpected string: "
fi
echo "_"${clean}"_"
# Test manufacturer

sudo mysql -N -e 'use c9_test; DELETE FROM products WHERE name LIKE "%Pocky%";'
sudo mysql -N -e 'use c9_test; DELETE FROM products WHERE name LIKE "%Wedderspoon%";'

sudo mysql -N -e 'drop database c9_test;'
