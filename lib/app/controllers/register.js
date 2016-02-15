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
