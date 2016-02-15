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

myApp.controller("LoginController", ["$rootScope", "$scope", "$http", "$location", function ($rootScope, $scope, $http, $location) {
	$rootScope.pageTitle = "Login";
	if (sessionStorage.loggedIn) {
		$location.path("/home");
	} else {
		$scope.showLogin = true;
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

		$http.post("serv/register", {
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
}]);

myApp.controller("HomeController", ["$rootScope", "$scope", "$location", "AuthCheckService", function ($rootScope, $scope, $location, AuthCheckService) {
	$rootScope.pageTitle = "Home";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		
	});
}]);

myApp.controller("GroupsController", ["$rootScope", "$scope", "$location", "AuthCheckService", function ($rootScope, $scope, $location, AuthCheckService) {
	$rootScope.pageTitle = "Groups";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		$scope.groups = [
			{
				id: "0",
				name: "Default",
				count: 5
			}, {
				id: "1",
				name: "Birthdays",
				count: 15
			}, {
				id: "2",
				name: "Anniversaries",
				count: 25
			}, {
				id: "3",
				name: "Work",
				count: 35
			}, {
				id: "4",
				name: "Miscellaneous",
				count: 45
			}, {
				id: "5",
				name: "This is my big group name",
				count: 55
			}
		];

		$scope.groupsCount = $scope.groups.length;

		$scope.edit = function (groupId) {
			alert("Edit: " + groupId);
		};

		$scope.delete = function (groupId) {
			if (confirm("Are you sure you want to delete the group '" + groupId + "' ?")) {

				// Delete it from the array also
				for (var a = 0; a < $scope.groups.length; a++) {
					if ($scope.groups[a].id == groupId) {
						$scope.groups.splice(a, 1);
						break;
					}
				}
				
				$scope.groupsCount = $scope.groups.length;
				$("#tblGroups [data-id='" + groupId + "']").animate({ height: "hide", opacity: "hide" }, "slow");
			}
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
