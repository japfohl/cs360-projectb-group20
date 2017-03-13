<?php
    require_once("../includes/config.php");

    if(isset($_GET["user_id"]) && isset($_GET["val_id"]))
    {
        $user_id = $_GET["user_id"];
        $val_id = $_GET["val_id"];
        $remove_query = "DELETE FROM users_values WHERE fk_user_id = ? AND fk_value_id = ?";
        
        $db = dbConnect();
        
        $stmt = $db->prepare($remove_query);
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