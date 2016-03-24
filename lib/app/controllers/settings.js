myApp.controller("SettingsController", ["$rootScope", "$scope", "$http", "$location", "AuthCheckService", function ($rootScope, $scope, $http, $location, AuthCheckService) {
	$rootScope.pageTitle = "Settings";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location, $http: $http }, function () {
		
		// Pre-fill the first name and password
		$scope.email = angular.fromJson(sessionStorage.userData).email,
		$scope.first_name = angular.fromJson(sessionStorage.userData).first_name,
		$scope.last_name = angular.fromJson(sessionStorage.userData).last_name,

		$scope.Login = {};
		$scope.Login.doUpdateProfile = function () {
			
			$scope.error = "";

			if (!$scope.first_name) {
				$scope.error = "Please enter the first name!";
				$("#first_name").focus();
				return;
			}

			if (!$scope.last_name) {
				$scope.error = "Please enter the last name!";
				$("#last_name").focus();
				return;
			}

			$http.post("serv/updateprofile", {
				user_id: angular.fromJson(sessionStorage.userData).user_id,
				login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
				first_name: $scope.first_name,
				last_name: $scope.last_name
			})
			.success(function (response) {
				if (response.success) {
					alert("Re-populate the session storage and the navbar first name.");

					$scope.error = "";
				} else {
					$scope.error = response.message;
				}
			})
			.error(function (response) {
				$scope.error = response.message;
			});
		};
	});
}]);
