<?php

    function dbConnect()
    {
    	$servername = "127.0.0.1";
    	$username = "root";
    	$password = "root";
    	$db = "recipes";
    
    	static $database;
    	
    	if(!isset($database)) // create new db connection if one does not already exist
    	{
    			//connect to database
    			$database = new mysqli($servername, $username, $password, $db);
    
    			if($database->connect_errno)
    			{
    				printf("Connect failed: " . $database->connect_error);
    			}
    	}
    	
    	return $database;
    }

    //redirect to a valid destination in the site
    function redirect($destination)
    {
    
        //http://php.net/manual/en/function.header.php
        $host = $_SERVER["HTTP_HOST"];
        $path = rtrim(dirname($_SERVER["PHP_SELF"]), "/\\");
        header("Location: http://$host$path/$destination");
    
    	// exit immediately since we're redirecting anyway
    	exit;
    }

    //render  template and pass in values
    function render($template, $values = [])
    {
    	//if template exists, render
    	if(file_exists("../templates/$template"))
    	{
    	    // extract variables from the incoming array
    		extract($values); 
        
    		//render header
    		require("../templates/header.php");
    		
    		//render template
    		require("../templates/$template");
    
    		//render footer
    		require("../templates/footer.php");
    	}
    	else
    	{
    		trigger_error("Invalid template: $template", E_USER_ERROR);
    	}
    }
?>