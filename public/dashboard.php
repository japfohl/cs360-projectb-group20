<?php
    require_once("../includes/config.php");
    
    if(isset($_GET["user_id"])) 
    {
        $user_id = $_GET["user_id"];
        $namequery = "SELECT u.firstname, u.lastname FROM users u WHERE u.user_id = ?";

        $query = "SELECT v.val_id, v.name, v.copy FROM vals v 
                INNER JOIN users_values uv ON v.val_id = uv.fk_value_id
                INNER JOIN users u ON uv.fk_user_id = u.user_id 
                WHERE user_id = ?";
        
        $db = dbConnect();
        
        // get name from database
        $stmt = $db->prepare($namequery);
        $stmt->bind_param('i', $user_id);
        
        if (!($stmt->execute()))
        {
            echo "Execution error!\n";
            die();
        }
        
        $stmt->bind_result($fname, $lname);
        $stmt->fetch();
        $stmt->close();
        
        // get values
        $stmt = $db->prepare($query);
        $stmt->bind_param('i', $user_id);
        
        if (!($stmt->execute()))
        {
            echo "Execution error!\n";
            die();
        }
        
        $stmt->bind_result($val_id, $vname, $vcopy);
        
        $uservals = array();
        
        while($stmt->fetch())
        {
            $uservals[] = array(
                "val_id" => $val_id,
                "vname" => $vname,
                "vcopy" => $vcopy
            );
        }
        
        $stmt->close();
        
        $query1 = "SELECT v.val_id, v.name, v.copy FROM vals v WHERE v.val_id NOT IN 
                (SELECT v.val_id FROM vals v 
                INNER JOIN users_values uv ON v.val_id = uv.fk_value_id
                INNER JOIN users u ON uv.fk_user_id = u.user_id 
                WHERE user_id = ?)";
        
        $stmt = $db->prepare($query1);
        $stmt->bind_param('i', $user_id);
        
        if (!($stmt->execute()))
        {
            echo "Execution error!\n";
            die();
        }
        
        $stmt->bind_result($val_id, $vname, $vcopy);
        
        $non_uservals = array();
        
        while($stmt->fetch())
        {
            $non_uservals[] = array(
                "val_id" => $val_id,
                "vname" => $vname,
                "vcopy" => $vcopy
            );
        }
        
        $stmt->close();
        
        render("user_dashboard.php", [
            "title" => "User Dashboard - $fname $lname", 
            "fname" => $fname, 
            "lname" => $lname, 
            "uservals" => $uservals,
            "non_uservals" => $non_uservals,
            "user_id" => $user_id,
            "customCSS" => "css/user_dashboard.css"]);
    }
    else
    {
        redirect("home.php");
    }
?>
