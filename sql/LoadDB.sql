

/*  
** Author: Shoshana Abrass, CS361
** Date: 2/28/17
** Description: Commands to fill the database with data for prototyping
sudo mysql
source LoadDB.sql;
*/


/*
  manufacturers
       man_id       INT
       name         VARCHAR(255)
 
  products
        product_id  INT
        name        VARCHAR(255)
        photo_url   VARCHAR(255)
        manufacturer INT
        realcost    DECIMAL(10,2)
  
  vals
        val_id      INT
        name        VARCHAR(255)
        copy        VARCHAR(2048)

  users
        user_id     INT
        firstname   VARCHAR(255)
        lastname    VARCHAR(255)
        username    VARCHAR(32)
        

  users_values
        fk_user_id
        fk_value_id

  manufacturers_values
        fk_mfct_id
        fk_value_id
        cost        INT         // This is a percentage from 0-> (maybe greater than 100)

*/
INSERT INTO manufacturers (name) VALUES
    ("LG"), ("Samsung"), ("Kenmore"), ("Pocky"), ("Wedderspoon"), ("Frigidaire");
    
INSERT INTO products(name, manufacturer, realcost, photo_url) VALUES 
    ("Side by Side 26 Cubic Feet Freestanding Refrigerator, Stainless Steel, model LSXS26366S", (SELECT man_id FROM manufacturers m WHERE m.name = 'LG'), 2255.88, "https://images-na.ssl-images-amazon.com/images/I/31ZdK-F7r%2BL.jpg"),
    ("Side by Side 25 Cubic Feet Refrigerator, Stainless Steel,  model 50023", (SELECT man_id FROM manufacturers m WHERE m.name = 'Kenmore'),1095.67,"https://images-na.ssl-images-amazon.com/images/I/318LH99V5hL.jpg"),
    ("Side by Side Ice Dispense Refrigerator, 25 cubic feet, Stainless Steel, model RS25H5121SRAA", (SELECT man_id FROM manufacturers m WHERE m.name = 'Samsung'), 1596.60,"https://images-na.ssl-images-amazon.com/images/I/51xliwqf4NL._SL1000_.jpg"),
    ("Side-By-Side Refrigerator 26.0 Cu. Ft. Pearl White, model FFSS2614QP", (SELECT man_id FROM manufacturers m WHERE m.name = 'Frigidaire'), 937.52, "https://images-na.ssl-images-amazon.com/images/I/51nMLvKrrQL._SL1000_.jpg"),
    ("Microwave, Over-The-Range Convection Microwave, 1.7 Cubic Feet, MC17F808KDT", (SELECT man_id FROM manufacturers m WHERE m.name = 'Samsung'), 670.00,"https://images-na.ssl-images-amazon.com/images/I/81F54aoOIiL._SL1500_.jpg"),
    ("Microwave, Over-The-Range Microwave Oven, 2.2 Cubic Feet, Stainless Steel, LMHM2237ST", (SELECT man_id FROM manufacturers m WHERE m.name = 'LG'), 390.00,"https://images-na.ssl-images-amazon.com/images/I/61U1veCsU%2BL._SL1248_.jpg"),
    ('Risio Mobile phone, 4G LTE Cricket, Titan 4.5" display, Android, 5MP Camera', (SELECT man_id FROM manufacturers m WHERE m.name = 'LG'), 149.00,"https://images-na.ssl-images-amazon.com/images/I/61uooc49SWL._SL1086_.jpg"),
    ("Galaxy J7 Mobile Phone, 16GB ROM/2GB ROM, 5.5 Inch white, Android",(SELECT man_id FROM manufacturers m WHERE m.name = 'Samsung'),149,"https://images-na.ssl-images-amazon.com/images/I/41Pn833WheL.jpg"),
    ("Phoenix 2 K371 Mobile phone, 4G LTE GSM, 5-Inch HD, 16GB, Android", (SELECT man_id FROM manufacturers m WHERE m.name = 'LG'), 70.00,"https://images-na.ssl-images-amazon.com/images/I/61Lw5c7TcoL._SL1000_.jpg");
 
INSERT INTO vals (name, copy) VALUES
    ("Fair Labor", "Company adheres to fair labor practices, living wage, safe conditions, and child labor standards"),
    ("Sustainable", "Company uses processes that minimize negative environmental impacts while conserving energy and natural resources"),
    ( 'US-Made', "Company manufactures in the United States");
    
INSERT INTO users (firstname, lastname, username) VALUES
    ("Pat", "Morrison", "patmo"),
    ("Alex", "Canning", "alcan"),
    ("Lou", "Pyrex", "loupy"),
    ("Taylor", "Terwilliger", "tater");

INSERT INTO users_values (fk_user_id, fk_value_id) VALUES
    ((SELECT user_id FROM users u WHERE u.username = 'patmo'), (SELECT val_id FROM vals v WHERE v.name = 'Fair Labor')),
    ((SELECT user_id FROM users u WHERE u.username = 'patmo'), (SELECT val_id FROM vals v WHERE v.name = 'Sustainable')),
    ((SELECT user_id FROM users u WHERE u.username = 'patmo'), (SELECT val_id FROM vals v WHERE v.name = 'US-Made')),
    ((SELECT user_id FROM users u WHERE u.username = 'alcan'), (SELECT val_id FROM vals v WHERE v.name = 'Fair Labor')),
    ((SELECT user_id FROM users u WHERE u.username = 'alcan'), (SELECT val_id FROM vals v WHERE v.name = 'Sustainable'));
    
INSERT INTO manufacturers_values (fk_mfct_id, fk_value_id, cost) VALUES
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'LG'), (SELECT val_id FROM vals v WHERE v.name = 'Fair Labor'), 10),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'LG'), (SELECT val_id FROM vals v WHERE v.name = 'Sustainable'), 20),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'LG'), (SELECT val_id FROM vals v WHERE v.name = 'US-Made'), 30),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Samsung'), (SELECT val_id FROM vals v WHERE v.name = 'Fair Labor'), 100),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Samsung'), (SELECT val_id FROM vals v WHERE v.name = 'Sustainable'), 200),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Samsung'), (SELECT val_id FROM vals v WHERE v.name = 'US-Made'), 400),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Frigidaire'), (SELECT val_id FROM vals v WHERE v.name = 'Fair Labor'), 1),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Frigidaire'), (SELECT val_id FROM vals v WHERE v.name = 'Sustainable'), 2),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Frigidaire'), (SELECT val_id FROM vals v WHERE v.name = 'US-Made'), 3),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Kenmore'), (SELECT val_id FROM vals v WHERE v.name = 'Fair Labor'), 1000),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Kenmore'), (SELECT val_id FROM vals v WHERE v.name = 'Sustainable'), 2000),
    ((SELECT man_id FROM manufacturers m WHERE m.name = 'Kenmore'), (SELECT val_id FROM vals v WHERE v.name = 'US-Made'), 4000);