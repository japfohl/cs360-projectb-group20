<?php
    require("../includes/config.php");
    
    $UnitTesting = false;
    $Debugging = false;

    if(isset($_GET["prodname"])) 
    {
        $prodname = filter_input(INPUT_GET, "prodname", FILTER_SANITIZE_SPECIAL_CHARS);
        $prepProdname = '%' . $prodname . '%';
        $prodQuery = "SELECT p.product_id, p.name, p.photo_url, p.realcost, m.name
                FROM products p INNER JOIN manufacturers m ON m.man_id = p.manufacturer
                WHERE p.name LIKE ?";
        $db = dbConnect();
        
        $stmt = $db->prepare($prodQuery);
        $stmt->bind_param('s', $prepProdname);
        
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
                "cost" => array(),
                "vcost" => 0
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
        $uservalQuery = "SELECT uv.fk_value_id, v.name FROM users_values uv INNER JOIN vals v ON uv.fk_value_id = v.val_id WHERE uv.fk_user_id = ?";
        
        $stmt = $db->prepare($uservalQuery);
        $stmt->bind_param('i', $userID);
        
        if (!($stmt->execute()))
        {
            echo "Execution error!\n";
            die();
        }
        
        
        $stmt->bind_result($uval, $vname);
        
        $userValues = array();
        
        while($stmt->fetch())
        {
            $userValues[] = array(
                "uval" => $uval,
                "vname" => $vname
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
                $stmt->bind_param('sd', $r["mname"], $v["uval"]);
                
                if (!($stmt->execute()))
                {
                    echo "Execution error!\n";
                    die();
                }
                $stmt->bind_result($cost);
                $stmt->fetch();
                $stmt->close();
                if ($Debugging){  echo "succeed with query for " . $v["uval"] . ", cost = " . $cost . "<p>"; }
                
                $r["cost"][$v["vname"]] = $cost;
            }
            $r["vcost"] = $r["pcost"];
            foreach ($r["cost"] as $key => $value)
            {
                $r["vcost"] += $value;
            }
        }

        $vcostTemp = array();
        foreach ($results as $res)
        {
            array_push($vcostTemp, $res["vcost"]);
        }
        
        array_multisort($vcostTemp, SORT_ASC, SORT_NUMERIC, $results );
        if ($Debugging) {
            echo "134 sorted array ";  echo var_dump($results);
        }
        
        if ( $UnitTesting){
            foreach ($results as $r)
            {
                echo "147 array len of r[cost] = " . sizeof($r["cost"]) . "listing: " . var_dump($r) . "<br>";
                foreach($r as $key => $value)
                {
                    if ($key == "cost") { 
                        echo "found a cost key, array len=" . sizeof($value).  ", ";
                        foreach ($value as $k => $v)
                        {
                            echo "key: " . $k . "value: " . $v ."; ";
                        }
                        echo "<br>";
                    }
                    else {
                        echo "Key: " . $key . ", Value:" . $value ."\n<br>";
                    }
                }
            }
        }
        
        render("results.php", ["title" => "Search Results", "prodname" => $prodname, "results" => $results]);
    }
    else
    {
        redirect("home.php");
    }

?>
