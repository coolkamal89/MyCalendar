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
		
		case		'login'			:	doLogin();
										break;
		
		case		'checklogin'	:	doCheckLogin();
										break;

		case		'logout'		:	doLogout();
										break;

		case		'register'		:	doRegister();
										break;

		case		'getgroups'		:	doGetGroups();
										break;

		case		'creategroup'	:	doCreateGroup();
										break;
		
		default						:	out_json(['success' => false, 'message' => 'Invalid command!']);
										break;
	}
	
	/*
	*	Function for validating and logging the user in
	*/
	function doLogin() {
		global $request;

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spLogin(:email, :password);');
		$query->execute([
			':email' => $request['email'],
			':password' => $request['password']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$pdo = null;

		$output = ['success' => false, 'data' => '', 'message' => 'Incorrect email or password!'];
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
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$pdo = null;

		$output = ['success' => false, 'data' => '', 'message' => 'Error while logging out!'];
		if ($result) {
			$output = ['success' => true, 'data' => '', 'message' => 'Successfully logged out!'];
		}

		out_json($output);
	}

	/*
	*	Function to check whether the user is logged in or not
	*/
	function doCheckLogin() {
		global $request;

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spCheckLogin(:user_id, :login_session_id);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$pdo = null;

		$output = ['success' => false, 'data' => '', 'message' => 'Invalid login!'];
		if ($result) {
			$output = ['success' => true, 'data' => $result, 'message' => 'Valid login!'];
		}

		out_json($output);
	}

	/*
	*	Function to register a user
	*/
	function doRegister() {
		global $request;

		if ($request['password'] !== $request['confirm_password']) {
			out_json(['success' => false, 'data' => '', 'message' => 'Password and confirm passwords do not match!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spRegister(:email, :password, :first_name, :last_name);');
		$query->execute([
			':email' => $request['email'],
			':password' => $request['password'],
			':first_name' => $request['first_name'],
			':last_name' => $request['last_name']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$output['data'] = (!empty($result) ? $result : '');

		$pdo = null;

		out_json($output);
	}

	/*
	*	Function to get groups of a user
	*/
	function doGetGroups() {
		global $request;

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spGetGroups(:user_id, :login_session_id);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id']
		]);
		$result = $query->fetchAll(PDO::FETCH_ASSOC);
		$pdo = null;

		$output = ['success' => false, 'data' => '', 'message' => 'Error while getting groups!'];
		if ($result) {
			$output = ['success' => true, 'data' => $result, 'message' => ''];
		}

		out_json($output);
	}

	/*
	*	Function to create a group
	*/
	function doCreateGroup() {
		global $request;

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spCreateGroup(:user_id, :login_session_id, :group_name);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':group_name' => $request['group_name']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetchAll(PDO::FETCH_ASSOC);
		$output['data'] = (!empty($result) ? $result : '');

		$pdo = null;

		out_json($output);
	}
?>