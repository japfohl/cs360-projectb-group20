<?php

    function dbConnect()
    {
    	$servername = getenv('IP');
        $username = getenv('C9_USER');
        $password = "";
        $dbname = "c9";
        $dbport = 3306;
    
    	static $database;
    	
    	if(!isset($database)) // create new db connection if one does not already exist
    	{
    			//connect to database
    			$database = new mysqli($servername, $username, $password, $dbname, $dbport);
    
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
    		
    		//require navbar
    		require("../templates/navbar.php");
    		
    		//render template
    		require("../templates/$template");
    	}
    	else
    	{
    		trigger_error("Invalid template: $template", E_USER_ERROR);
    	}
    }
    
    // render("landing_form.php", ["title" =>"Welcome", "customCSS" => "landing.css", "customJS" => "landing.js"]);
?>
