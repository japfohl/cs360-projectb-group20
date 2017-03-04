<?php
    require("../includes/config.php");
    
    if(isset($_GET["prodname"])) 
    {
        $prodname = filter_input(INPUT_GET, "prodname", FILTER_SANITIZE_SPECIAL_CHARS);
        $query = "SELECT p.product_id, p.name, p.photo_url, p.realcost, m.name
                FROM products p INNER JOIN manufacturers m ON m.man_id = p.manufacturer
                WHERE p.name LIKE '%" . $prodname . "%'";
        $db = dbConnect();
        
        $stmt = $db->prepare($query);
        // $stmt->bind_param('s', $prodname);
        
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
                "mname" => $mname
            );
        }
        
        $stmt->close();

        // Unit Test
        // foreach ($results as $r)
        
        // {
        //     echo $r["pid"] . "\n";
        //     echo $r["pname"] . "\n";
        //     echo $r["purl"] . "\n";
        //     echo $r["pcost"] . "\n";
        //     echo $r["mname"] . "\n";
        // }   
        
        render("results.php", ["title" => "Search Results", "results" => $results]);
    }
    else
    {
        redirect("home.php");
    }
?>
