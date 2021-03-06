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
	$request = json_decode(file_get_contents('php://input'), true);
	$command = explode('/', $_SERVER['PATH_INFO'])[1];

	switch (trim(strtolower($command))) {
		
		case		'login'				:	doLogin();
											break;
		
		case		'checklogin'		:	doCheckLogin();
											break;

		case		'logout'			:	doLogout();
											break;

		case		'register'			:	doRegister();
											break;

		case		'getgroups'			:	doGetGroups();
											break;

		case		'creategroup'		:	doCreateGroup();
											break;

		case		'deletegroup'		:	doDeleteGroup();
											break;

		case		'editgroup'			:	doEditGroup();
											break;

		case		'getgroupdetails'	:	doGetGroupDetails();
											break;

		case		'geteventsbyid'		:	doGetEventsByGroupId();
											break;

		case		'createevent'		:	doCreateEvent();
											break;

		case		'updateprofile'		:	doUpdateProfile();
											break;

		case		'changepassword'	:	doChangePassword();
											break;

		case 		'editevent'			:	doEditEvent();
											break;
		
		default							:	out_json(['success' => false, 'message' => 'Invalid command!']);
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
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

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

		if ($request['group_name'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the group name!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spCreateGroup(:user_id, :login_session_id, :group_name, :group_star);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':group_name' => $request['group_name'],
			':group_star' => $request['group_star']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetchAll(PDO::FETCH_ASSOC);

		if (!empty($result)) {
			$output['data'] =  $result;
		} else {
			$output['data'] = '';
		}

		$pdo = null;

		out_json($output);
	}

	function doDeleteGroup() {
		global $request;

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spDeleteGroup(:user_id, :login_session_id, :group_id);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':group_id' => $request['group_id']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$pdo = null;

		$output = ['success' => false, 'data' => '', 'message' => 'Error deleting group!'];
		if ($result) {
			$output = ['success' => true, 'data' => '', 'message' => 'Group successfully deleted!'];
		}

		out_json($output);
	}

	function doEditGroup() {
		global $request;

		if ($request['group_name'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the group name!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spEditGroup(:user_id, :login_session_id, :group_id, :group_name, :group_star);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':group_id' => $request['group_id'],
			':group_name' => $request['group_name'],
			':group_star' => $request['group_star']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetchAll(PDO::FETCH_ASSOC);

		if (!empty($result)) {
			$output['data'] =  $result;
		} else {
			$output['data'] = '';
		}

		$pdo = null;

		out_json($output);
	}

	function doUpdateProfile() {
		global $request;

		if ($request['first_name'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the first name!']);
		}

		if ($request['last_name'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the last name!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spUpdateProfile(:user_id, :login_session_id, :first_name, :last_name);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':first_name' => $request['first_name'],
			':last_name' => $request['last_name']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetch(PDO::FETCH_ASSOC);

		if (!empty($result)) {
			$output['data'] =  $result;
		} else {
			$output['data'] = '';
		}

		$pdo = null;

		out_json($output);
	}

	function doChangePassword() {
		global $request;

		if ($request['password'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the old password!']);
		}

		if ($request['new_password'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the new password!']);
		}

		if ($request['new_password'] != $request['confirm_new_password']) {
			out_json(['success' => false, 'data' => '', 'message' => 'New and confirm new passwords do not match!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spChangePassword(:user_id, :login_session_id, :password, :new_password);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':password' => $request['password'],
			':new_password' => $request['new_password']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

		$output = $result;

		$pdo = null;

		out_json($output);
	}

	function doGetEventsByGroupId() {
		global $request;

		if ($request['group_id'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the group id!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spGetEventsByGroupId(:user_id, :login_session_id, :group_id);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':group_id' => $request['group_id']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetchAll(PDO::FETCH_ASSOC);

		if (!empty($result)) {
			$output['data'] =  $result;
		} else {
			$output['data'] = '';
		}

		$pdo = null;

		out_json($output);
	}

	function doCreateEvent() {
		global $request;

		if ($request['group_id'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the group id!']);
		}

		if ($request['event_name'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the event name!']);
		}

		if ($request['event_date'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the event date!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spCreateEvent(:user_id, :login_session_id, :group_id, :event_name, :event_date);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':group_id' => $request['group_id'],
			':event_name' => $request['event_name'],
			':event_date' => $request['event_date']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetchAll(PDO::FETCH_ASSOC);

		if (!empty($result)) {
			$output['data'] =  $result;
		} else {
			$output['data'] = '';
		}

		$pdo = null;

		out_json($output);
	}

	function doGetGroupDetails() {
		global $request;

		if ($request['group_id'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the group id!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spGetGroupDetails(:user_id, :login_session_id, :group_id);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':group_id' => $request['group_id']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetch(PDO::FETCH_ASSOC);

		if (!empty($result)) {
			$output['data'] =  $result;
		} else {
			$output['data'] = '';
		}

		$pdo = null;

		out_json($output);
	}

	function doEditEvent() {
		global $request;

		if ($request['event_id'] == '') {
			out_json(['success' => false, 'data' => '', 'message' => 'Please specify the event id!']);
		}

		$pdo = new PDO('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME, DB_USER, DB_PASS);
		$query = $pdo->prepare('CALL spEditEvent(:user_id, :login_session_id, :group_id, :group_name, :group_star);');
		$query->execute([
			':user_id' => $request['user_id'],
			':login_session_id' => $request['login_session_id'],
			':group_id' => $request['group_id'],
			':group_name' => $request['group_name'],
			':group_star' => $request['group_star']
		]);
		$result = $query->fetch(PDO::FETCH_ASSOC);
		$result['success'] = ($result['success'] == '1' ? true : false);
		$result['message'] = (!$result['success'] && $result['message'] == '' ? "An error occured!" : $result['message']);

		$output = $result;

		$query->nextRowset();
		$result = $query->fetchAll(PDO::FETCH_ASSOC);

		if (!empty($result)) {
			$output['data'] =  $result;
		} else {
			$output['data'] = '';
		}

		$pdo = null;

		out_json($output);
	}
?>
