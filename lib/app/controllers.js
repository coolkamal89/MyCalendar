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
