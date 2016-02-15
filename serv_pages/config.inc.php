<?php

	/*
	*	Database connection constants
	*/
	define('DB_HOST', 'localhost');
	define('DB_PORT', '3306');
	define('DB_USER', 'root');
	define('DB_PASS', '');
	define('DB_NAME', 'MyDatesDB');

	/*
	*	Debugging variable
	*/
	// $debug = true;
	$debug = ($_SERVER['SERVER_NAME'] === 'kamal');

	/*
	*	Enable error reporting if debug variable is set to true
	*/
	if ($debug === true) {
		error_reporting(E_ERROR);
		ini_set('display_errors', true);
	}
?>