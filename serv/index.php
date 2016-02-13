<?php
	$postdata = file_get_contents("php://input");
	$request = json_decode($postdata, true);

	switch (trim(strtolower($request["cmd"]))) {
		case		"login"		:	doLogin();
									break;
		
		case		"logout"	:	doLogout();
									break;
		
		default			:	header("Content-Type: application/json");
							echo json_encode(array(
								"status" => false,
								"message" => "Invalid Command!"
							));
	}
	
	function doLogin() {
		global $request;

		$output = ["success" => false, "message" => "Invalid username or password!"];
		if (($request["username"] == "kamal" && $request["password"] == "kamal") || $request["username"] == "asd" && $request["password"] == "asd") {
			$output["success"] = true;
			$output["message"] = "";
			$output["data"] = [
				"userId" => "1",
				"userName" => $request["username"],
				"loginSessionId" => strtoupper(uniqid())
			];
		}

		header("Content-Type: application/json");
		echo json_encode($output);
	}
	
	function doLogout() {
		$output = ["success" => true, "message" => ""];
		header("Content-Type: application/json");
		echo json_encode($output);
	}

?>