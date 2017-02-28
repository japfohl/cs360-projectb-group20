<?php
/*
** Author: Collin James, CS 340
** Date: 6/4/16
** Description: Final Project - getprodlist.php
*/ 

	include 'mysqli.php'; // get login credentials


		/* get all product info given a list id */
		if(!($stmt = $db->prepare("SELECT p.product_id, p.name, p.photo_url FROM products p GROUP BY p.name" ))){
			echo "Prepare failed: "  . $stmt->errno . " " . $stmt->error;
		}

		if(!($stmt->bind_param("i", $listid))){
			echo "Bind failed: "  . $stmt->errno . " " . $stmt->error;
		}

		if(!$stmt->execute()){
			echo "Execute failed: "  . $db->connect_errno . " " . $db->connect_error;
		}
		if(!$stmt->bind_result($product_id, $pname, $photourl)){
			echo "Bind failed: "  . $db->connect_errno . " " . $db->connect_error;
		}

		// if items in list, for each item fetch and process (shouldn't be pname if no item)
		/* make a div for each item */
		while($stmt->fetch() && $pname){
			$productinfo = "<div class=\"product\" data-pid='$product_id'><h1>$pname</h1>";
		 	// $productinfo .= ($mname) ? "<h2>Made by <span>$mname</span></h2>" : "";
			// check that url is actually a url
			$productinfo .=  (strpos($photourl, "http") !== false) ? "<img src=\"$photourl\" height=\"100\">" : "";
			// // $productinfo .= "<ul>";
			// // if($bought){
			// // 	$productinfo .= "<li>You own this! (It was \$$price)</li>"; 
			// // } else {
			// // 	if($sname){
			// // 		$productinfo .= "<li>Buy at ";
			// // 		$productinfo .= ($produrl) ? "<a href=\"$produrl\">$sname</a>" : $sname;
			// // 		$productinfo .= ($price) ? " for <span>$price</span></li>" : "</li>";
			// // 	}
				
			// // }
			// // $productinfo .= "</ul>
			// <button class='prod_update'>Edit Info</button>";
			if($bought)
				$productinfo .= "<button class='got_it' data-id=0>I need more!</button>";
			else
				$productinfo .= "<button class='got_it' data-id=1>I got it!</button>";
			$productinfo .= "<button class='prod_remove'>Remove</button>
			</div>";
			$html .= $productinfo;
		}
		// if no items in list
		if(!$pname) {
			$productinfo .= "<h1>No items</h1>";
			$html .= $productinfo;
		}

		$stmt->close();

		$html = $html . "</div>";
	} else { // no valid listid; let the user know
		$html = "<h1>No user/list</h1>";
	}
	echo $html;
?>