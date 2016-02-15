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
