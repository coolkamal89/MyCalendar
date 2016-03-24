myApp.controller("GroupController", ["$rootScope", "$scope", "$http", "$location", "$routeParams", "AuthCheckService", function ($rootScope, $scope, $http, $location, $routeParams, AuthCheckService) {
	$rootScope.pageTitle = "Group";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		$scope.groupId = $routeParams.groupId;

		$http.post("serv/geteventsbyid", {
			user_id: angular.fromJson(sessionStorage.userData).user_id,
			login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
			group_id: $routeParams.groupId
		})
		.success(function (response) {
			if (response.success) {
				$scope.events = response.data;
				$scope.eventsCount = $scope.groups.length;
			} else {
				alert(response.message);
			}
		})
		.error(function (response) {
			alert(response.message);
		});

	});
}]);

myApp.controller("DatesController", ["$rootScope", "$scope", "$location", "AuthCheckService", function ($rootScope, $scope, $location, AuthCheckService) {
	$rootScope.pageTitle = "Dates";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		
	});
}]);
