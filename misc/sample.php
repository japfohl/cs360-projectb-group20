<?php
/*
** Author: Collin James, CS 361
** Date: 2/26/17
** Description: display all items in products test table (see Test.sql)
** https://project-b-cjames.c9users.io/getprodlist.php
*/

	include './mysqli.php'; // get login credentials/connect if necessary

	/*get all product info */
	if(!($stmt = $db->prepare("SELECT p.product_id, p.name, p.photo_url FROM products p GROUP BY p.name" )))
	{
		echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
	}

	if(!$stmt->execute())
	{
		echo "Execute failed: "  . $db->connect_errno . " " . $db->connect_error;
	}
	
	if(!$stmt->bind_result($product_id, $pname, $photourl))
	{
		echo "Bind failed: "  . $db->connect_errno . " " . $db->connect_error;
	}

	$html = "";

	/* make a div for each item */
	while($stmt->fetch() && $pname)
	{
		$productinfo = "<div class=\"product\" data-pid='$product_id'><h1>$pname</h1>";
	 	
		// check that url is actually a url
		$productinfo .=  (strpos($photourl, "http") !== false) ? "<img src=\"$photourl\" height=\"100\">" : "";

		if($bought)
		{
			$productinfo .= "<button class='got_it' data-id=0>I need more!</button>";
		}
		else
		{
			$productinfo .= "<button class='got_it' data-id=1>I got it!</button>";
		}
		
		$productinfo .= "<button class='prod_remove'>Remove</button></div>";
		
		$html .= $productinfo;
	}
	
	// if no items in list
	if(!$pname) 
	{
		$productinfo .= "<h1>No items</h1>";
		$html .= $productinfo;
	}

	$stmt->close();

	$html = $html . "</div>";

	echo $html;
?>