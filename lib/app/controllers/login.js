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

