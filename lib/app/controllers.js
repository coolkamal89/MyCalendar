myApp.controller("NavBarController", ["$rootScope", "$scope", "$http", "$location", function ($rootScope, $scope, $http, $location) {
	$scope.isActive = function (viewLocation) { 
        return $location.path().indexOf(viewLocation) !== -1;
    };

    $rootScope.showNav = (sessionStorage.loggedIn === "true");

    $scope.Login = {};
    $scope.Login.logout = function () {
    	$http.post("serv/logout", {
			user_id: angular.fromJson(sessionStorage.userData).user_id,
			login_session_id: angular.fromJson(sessionStorage.userData).login_session_id
		})
		.success(function (response) {
			delete sessionStorage.loggedIn;
			delete sessionStorage.userData;
			$scope.showHome = false;
			$location.path("/login");
			$rootScope.showNav = false;
		})
		.error(function (response) {
			alert(response.message);
		});
	};
}]);

myApp.controller("LoginController", ["$rootScope", "$scope", "$http", "$location", "$routeParams", function ($rootScope, $scope, $http, $location, $routeParams) {
	$rootScope.pageTitle = "Login";
	if (sessionStorage.loggedIn) {
		$location.path("/home");
	} else {
		$scope.showLogin = true;
	}

	if ($routeParams.params == "session_timeout=1") {
		$scope.loginLoadError = "Your session has been timed out. Please login again!";
	}

	$scope.Login = {};
	$scope.Login.doLogin = function () {
		$scope.error = "";

		if (!$scope.email) {
			$scope.error = "Please enter email!";
			$("#email").focus();
			return;
		}

		if (!$scope.password) {
			$scope.error = "Please enter password!";
			$("#password").focus();
			return;
		}

		$http.post("serv/login", {
			email: $scope.email,
			password: $scope.password
		})
		.success(function (response) {
			if (response.success) {
				sessionStorage.loggedIn = true;
				sessionStorage.userData = angular.toJson(response.data);
				$location.path("/home");
				$rootScope.showNav = true;
			} else {
				$scope.error = response.message;
			}
		})
		.error(function (response) {
			$scope.error = response.message;
		});
	};

	$scope.viewForgot = function () {
		alert("Under development");
	};
}]);

myApp.controller("RegisterUserController", ["$rootScope", "$scope", "$http", "$location", function ($rootScope, $scope, $http, $location) {
	$rootScope.pageTitle = "Login";
	if (sessionStorage.loggedIn) {
		$location.path("/home");
	} else {
		$scope.showLogin = true;
	}

	$scope.Login = {};
	$scope.Login.doRegister = function () {
		$scope.error = "";

		if (!$scope.email) {
			$scope.error = "Please enter email!";
			$("#email").focus();
			return;
		}

		if (!$scope.password) {
			$scope.error = "Please enter password!";
			$("#password").focus();
			return;
		}

		if (!$scope.confirm_password) {
			$scope.error = "Please enter confirm password!";
			$("#confirm_password").focus();
			return;
		}

		if ($scope.password != $scope.confirm_password) {
			$scope.error = "Password and confirm passwords do not match!";
			$("#confirm_password").focus();
			return;
		}

		if (!$scope.first_name) {
			$scope.error = "Please enter first name!";
			$("#first_name").focus();
			return;
		}

		if (!$scope.last_name) {
			$scope.error = "Please enter last name!";
			$("#last_name").focus();
			return;
		}

		$http.post("serv/register", {
			email: $scope.email,
			password: $scope.password,
			confirm_password: $scope.confirm_password,
			first_name: $scope.first_name,
			last_name: $scope.last_name
		})
		.success(function (response) {
			if (response.success) {
				sessionStorage.loggedIn = true;
				sessionStorage.userData = angular.toJson(response.data);
				$location.path("/home");
				$rootScope.showNav = true;
			} else {
				$scope.error = response.message;
			}
		})
		.error(function (response) {
			$scope.error = response.message;
		});
	};
}]);

myApp.controller("HomeController", ["$rootScope", "$scope", "$location", "AuthCheckService", function ($rootScope, $scope, $location, AuthCheckService) {
	$rootScope.pageTitle = "Home";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		
	});
}]);

myApp.controller("GroupsController", ["$rootScope", "$scope", "$location", "$http", "AuthCheckService", function ($rootScope, $scope, $location, $http, AuthCheckService) {
	$rootScope.pageTitle = "Groups";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {

		/*
		*	Load user's groups
		*/
		$http.post("serv/getgroups", {
			user_id: angular.fromJson(sessionStorage.userData).user_id,
			login_session_id: angular.fromJson(sessionStorage.userData).login_session_id
		})
		.success(function (response) {
			$scope.groups = response.data;
			$scope.groupsCount = $scope.groups.length;
		})
		.error(function (response) {
			$scope.error = response.message;
		});

		/*
		*	Creating a user group
		*/
		$scope.createGroup = function () {

			$scope.createGroupError = "";

			if (!$scope.create_group_name) {
				$scope.createGroupError = "Please enter group name!";
				$("#create_group_name").focus();
				return;
			}

			$http.post("serv/creategroup", {
				user_id: angular.fromJson(sessionStorage.userData).user_id,
				login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
				group_name: $scope.create_group_name
			})
			.success(function (response) {
				if (response.success) {
					$scope.groups = response.data;
					$scope.groupsCount = $scope.groups.length;

					$scope.createGroupError = "";
					$scope.create_group_name = "";
				} else {
					$scope.createGroupError = response.message;
				}
			})
			.error(function (response) {
				$scope.createGroupError = response.message;
			});
		};

		/*
		*	Deleting a user group
		*/
		$scope.deleteGroup = function (groupId, groupName) {
			if (confirm("Are you sure you want to delete the group '" + groupName + "' ?")) {

				$http.post("serv/deletegroup", {
					user_id: angular.fromJson(sessionStorage.userData).user_id,
					login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
					group_id: groupId
				})
				.success(function (response) {
					if (response.success) {
						
						// Delete it from the array also
						for (var a = 0; a < $scope.groups.length; a++) {
							if ($scope.groups[a].id == groupId) {
								$scope.groups.splice(a, 1);
								break;
							}
						}
						
						$scope.groupsCount--;
						$("#tblGroups [data-id='" + groupId + "']").animate({ height: "hide", opacity: "hide" }, "slow");
					} else {
						alert(response.message);
					}
				})
				.error(function (response) {
					alert(response.message);
				});
			}
		};

		$scope.editGroup = function (groupId) {
			alert("Edit: " + groupId);
		};

	});
}]);

myApp.controller("GroupController", ["$rootScope", "$scope", "$location", "$routeParams", "AuthCheckService", function ($rootScope, $scope, $location, $routeParams, AuthCheckService) {
	$rootScope.pageTitle = "Group";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		$scope.groupUrl = $routeParams.groupUrl;
		$scope.groupId = $routeParams.groupId;
	});
}]);

myApp.controller("DatesController", ["$rootScope", "$scope", "$location", "AuthCheckService", function ($rootScope, $scope, $location, AuthCheckService) {
	$rootScope.pageTitle = "Dates";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		
	});
}]);

myApp.controller("SettingsController", ["$rootScope", "$scope", "$location", "AuthCheckService", function ($rootScope, $scope, $location, AuthCheckService) {
	$rootScope.pageTitle = "Settings";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		
	});
}]);
