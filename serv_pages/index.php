<?php
	require_once(__DIR__ . '/config.inc.php');
	require_once(__DIR__ . '/functions.inc.php');

	/*
	*	CSRF Check
	*
	*	Check whether the API request is coming from the same server
	*/
	if ($debug !== true) {
		if (parse_url($_SERVER['HTTP_REFERER'])['host'] != $_SERVER['SERVER_NAME']) {
			out_json(['success' => false, 'message' => 'Invalid Request!']);
		}
	}

	/*
	*	Getting the API request url and the post data
	*/
	$postdata = file_get_contents('php://input');
	$request = json_decode($postdata, true);

	$request_url = explode('/', $_SERVER['PATH_INFO']);

	switch (trim(strtolower($request_url[1]))) {
		case		'login'		:	doLogin();
									break;
		
		case		'logout'	:	doLogout();
									break;
		
		default					:	out_json(['success' => false, 'message' => 'Invalid Command!']);
									break;
	}
	
	/*
	*	Function for validating and logging the user in
	*/
	function doLogin() {
		global $request;

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spLogin(:email, :password);');
		$query->execute(array(':email' => $request['email'], ':password' => $request['password']));
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$pdo = null;

		$output = ['success' => false, 'data' => '', 'message' => 'Invalid email or password!'];
		if ($result) {
			$output = ['success' => true, 'data' => $result, 'message' => ''];
		}

		out_json($output);
	}
	
	/*
	*	Function for logging the user out
	*/
	function doLogout() {
		global $request;

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spLogout(:user_id, :login_session_id);');
		$query->execute(array(':user_id' => $request['user_id'], ':login_session_id' => $request['login_session_id']));
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$pdo = null;

		$output = ['success' => false, 'data' => '', 'message' => 'Error while logging out!'];
		if ($result) {
			$output = ['success' => true, 'data' => '', 'message' => 'Successfully logged out!'];
		}

		out_json($output);
	}

?>