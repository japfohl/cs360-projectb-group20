<?php
    require("../includes/config.php");

    $db = dbConnect();
    
    $sql = "SELECT p.name as p_name, p.photo_url, p.realcost, m.name as m_name
            FROM products p
            INNER JOIN manufacturers m ON m.man_id = p.manufacturer;";
            
    $result = $db->query($sql);
    $productInfo = $result->fetch_array(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Test Page</title>
</head>
<body>
    <?php foreach($productInfo as $p): ?>
        <h1><?php echo $p["p_name"]; ?></h1>
    <?php endforeach; ?>
</body>
</html>