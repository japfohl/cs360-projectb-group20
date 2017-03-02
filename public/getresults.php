<?php
    require("../includes/config.php");
    $db = dbConnect();

    $sql = "SELECT p.name as p_name, p.photo_url, p.realcost, m.name as m_name
            FROM products p
            INNER JOIN manufacturers m ON m.man_id = p.manufacturer;";
            
    $result = $db->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Test Page</title>
</head>
<body>
<?php while ($productInfo = $result->fetch_array(MYSQLI_ASSOC)) { ?>
       
       <h3><?php echo $productInfo['p_name']; ?></h3>
       <img src="<?php echo $productInfo['photo_url']; ?>"></img>
       <p>Name: <?php echo $productInfo['m_name']; ?></p>
       <p>Price: <?php echo $productInfo['realcost']; ?></p>

<?php } ?>

</body>
</html>