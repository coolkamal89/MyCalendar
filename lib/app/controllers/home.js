myApp.controller("HomeController", ["$rootScope", "$scope", "$location", "AuthCheckService", function ($rootScope, $scope, $location, AuthCheckService) {
	$rootScope.pageTitle = "Home";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		
	});
}]);
