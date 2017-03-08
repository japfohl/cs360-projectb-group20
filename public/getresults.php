<?php
    require("../includes/config.php");
    
    $UnitTesting = false;
    $Debugging = false;
    
    if(isset($_GET["prodname"])) 
    {
         
        $prodname = filter_input(INPUT_GET, "prodname", FILTER_SANITIZE_SPECIAL_CHARS);
        $prodname = '%' . $prodname . '%';
        $prodQuery = "SELECT p.product_id, p.name, p.photo_url, p.realcost, m.name
                FROM products p INNER JOIN manufacturers m ON m.man_id = p.manufacturer
                WHERE p.name LIKE ?";
        
        $db = dbConnect();
        
        $stmt = $db->prepare($prodQuery);
        $stmt->bind_param('s', $prodname);
        
        if (!($stmt->execute()))
        {
            echo "Execution error!\n";
            die();
        }
        
        
        $stmt->bind_result($pid, $pname, $purl, $pcost, $mname);
        
        $results = array();
        
        while($stmt->fetch())
        {
            $results[] = array(
                "pid" => $pid,
                "pname" => $pname,
                "purl" => $purl,
                "pcost" => $pcost,
                "mname" => $mname,
                "cost" => array()
            );
        }
        
        $stmt->close();

        if ($UnitTesting) {
            // Unit Test
            echo "<h2>Test results for the results table: </h2>";
            foreach ($results as $r)
            {
                echo $r["pid"] . "\n<p>";
                echo $r["pname"] . "\n<p>";
                echo $r["purl"] . "\n<p>";
                echo $r["pcost"] . "\n<p>";
                echo $r["mname"] . "\n<p>";
            }   
        }

        // Getting user values information
        $userID = 1; // Hardcoded
        $uservalQuery = "SELECT fk_value_id FROM users_values WHERE fk_user_id = ?";
        
        $stmt = $db->prepare($uservalQuery);
        $stmt->bind_param('i', $userID);
        
        if (!($stmt->execute()))
        {
            echo "Execution error!\n";
            die();
        }
        
        
        $stmt->bind_result($uval);
        
        $userValues = array();
        
        while($stmt->fetch())
        {
            $userValues[] = array(
                "uval" => $uval
            );
        }
        
        $stmt->close();
        
        if ($UnitTesting) {
            // Unit Test
            echo "<h2>Test results for the user values results table: </h2>";
            foreach ($userValues as $r)
            {
                echo $r["uval"] . "\n";
            }   
        }

        foreach ($results as &$r)
        {
            if ($Debugging){  echo "mname = " . $r["mname"] . "\n<p>";  }
            foreach ($userValues as $v)
            {    
                if ($Debugging){  echo "userValue = " . $v["uval"] . "\n<p>"; }
                $costQuery = "SELECT cost FROM manufacturers_values mv INNER JOIN manufacturers m ON mv.fk_mfct_id = m.man_id
                                WHERE m.name = ? AND mv.fk_value_id = ?";
                if ($Debugging){  echo "costQuery is " . $costQuery . "<p>";}
                $stmt = $db->prepare($costQuery);
                $stmt->bind_param('sd', $r["mname"], $v);
                
                if (!($stmt->execute()))
                {
                    echo "Execution error!\n";
                    die();
                }
                $stmt->bind_result($cost);
                $stmt->fetch();
                $stmt->close();
                if ($Debugging){  echo "succeed with query for " . $v["uval"] . ", cost = " . $cost . "<p>"; }
                
                $r["cost"][(string)$v["uval"]] =  $cost;
            }
        }
        
        if ( $UnitTesting){
            foreach ($results as $r):
                echo "147 array len of r[cost] = " . sizeof($r["cost"]) . "listing: " . var_dump($r) . "<br>";
                foreach($r as $key => $value):
                    if ($key == "cost") { 
                        echo "found a cost key, array len=" . sizeof($value).  ", ";
                        foreach ($value as $k => $v):
                            echo "key: " . $k . "value: " . $v ."; ";
                        endforeach;
                        echo "<br>";
                    }
                    else {
                        echo "Key: " . $key . ", Value:" . $value ."\n<br>";
                    }
                endforeach;
            endforeach;
        }
        
        render("results.php", ["title" => "Search Results", "results" => $results]);
    }
    else
    {
        redirect("home.php");
    }
?>
