<?php
    require_once("../includes/config.php");

    if(isset($_GET["user_id"]) && isset($_GET["val_id"]))
    {
        $user_id = $_GET["user_id"];
        $val_id = $_GET["val_id"];
        $add_query = "INSERT INTO users_values (fk_user_id, fk_value_id) VALUES (?,?)";
        
        $db = dbConnect();
        
        $stmt = $db->prepare($add_query);
        $stmt->bind_param('ii', $user_id, $val_id);
        
        if (!($stmt->execute()))
        {
            echo "Execution error!\n";
            die();
        }
 
        $stmt->close();
        
        require("dashboard.php");
    }
    else
        redirect("home.php");

?>