myApp.controller("SettingsController", ["$rootScope", "$scope", "$http", "$location", "AuthCheckService", function ($rootScope, $scope, $http, $location, AuthCheckService) {
	$rootScope.pageTitle = "Settings";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location, $http: $http }, function () {
		
		// Pre-fill the first name and password
		$scope.email = angular.fromJson(sessionStorage.userData).email,
		$scope.first_name = angular.fromJson(sessionStorage.userData).first_name,
		$scope.last_name = angular.fromJson(sessionStorage.userData).last_name,

		$scope.Login = {};
		$scope.Login.doUpdateProfile = function () {
			
			$scope.updateProfileError = "";
			$scope.updateProfileSuccess ="";

			if (!$scope.first_name) {
				$scope.updateProfileError = "Please enter the first name!";
				$("#first_name").focus();
				return;
			}

			if (!$scope.last_name) {
				$scope.updateProfileError = "Please enter the last name!";
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

					// Set the error to blank and hide
					$scope.updateProfileError = "";

					// Set the login data back to the sessionStorage
					sessionStorage.userData = angular.toJson(response.data);

					// Update the first name in the navbar's rootScope variable to auto reflect
					$rootScope.login_first_name = angular.fromJson(sessionStorage.userData).first_name;

					// Notify the user that the operation is successfully completed
					$scope.updateProfileSuccess = "Profile successfully updated!";
				} else {
					$scope.updateProfileError = response.message;
				}
			})
			.error(function (response) {
				$scope.updateProfileError = response.message;
			});
		};

		$scope.Login.doChangePassword = function () {
			
			$scope.changePasswordError = "";
			$scope.changePasswordSuccess = "";

			if (!$scope.password) {
				$scope.changePasswordError = "Please enter the old password!";
				$("#password").focus();
				return;
			}

			if (!$scope.new_password) {
				$scope.changePasswordError = "Please enter the new password!";
				$("#new_password").focus();
				return;
			}

			if ($scope.new_password != $scope.confirm_new_password) {
				$scope.changePasswordError = "New and confirm new passwords do not match!";
				$("#confirm_new_password").focus();
				return;
			}

			$http.post("serv/changepassword", {
				user_id: angular.fromJson(sessionStorage.userData).user_id,
				login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
				password: $scope.password,
				new_password: $scope.new_password,
				confirm_new_password: $scope.confirm_new_password
			})
			.success(function (response) {
				if (response.success) {

					// Set the error to blank and hide
					$scope.changePasswordError = "";

					// Notify the user that the operation is successfully completed
					$scope.changePasswordSuccess = "Password changed successfully!";
				} else {
					$scope.changePasswordError = response.message;
				}
			})
			.error(function (response) {
				$scope.changePasswordError = response.message;
			});
		};
	});
}]);
