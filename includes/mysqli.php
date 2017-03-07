<?php
/*
** Author: Collin James, CS 361
** Date: 2/26/17
** Description: connection to db; can be included in other php files
** See: https://community.c9.io/t/setting-up-mysql/1718#section-can-i-use-my-own-mysql-credentials-
*/
	$servername = getenv('IP');
    $username = getenv('C9_USER');
    $password = "";
    $database = "c9";
    $dbport = 3306;

	/*create the db connection */
	if(!$db)
	{
		$db = new mysqli($servername, $username,$password, $database, $dbport);

		// Check connection
	    if ($db->connect_error)
	    {
	        die("Connection failed: " . $db->connect_error);
	    }

	    echo "Connected successfully (".$db->host_info.")"; // testing
	}

?>