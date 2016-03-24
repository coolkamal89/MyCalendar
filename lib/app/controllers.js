myApp.controller("GroupController", ["$rootScope", "$scope", "$http", "$location", "$routeParams", "AuthCheckService", function ($rootScope, $scope, $http, $location, $routeParams, AuthCheckService) {
	$rootScope.pageTitle = "Group";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		$scope.groupId = $routeParams.groupId;

		$http.post("serv/getgroupdetails", {
			user_id: angular.fromJson(sessionStorage.userData).user_id,
			login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
			group_id: $routeParams.groupId
		})
		.success(function (response) {
			if (response.success) {
				$scope.groupName = response.data.group_name;
			} else {
				alert(response.message);
			}
		})
		.error(function (response) {
			alert(response.message);
		});

		$http.post("serv/geteventsbyid", {
			user_id: angular.fromJson(sessionStorage.userData).user_id,
			login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
			group_id: $routeParams.groupId
		})
		.success(function (response) {
			if (response.success) {
				$scope.events = response.data;
				$scope.eventsCount = $scope.events.length;
			} else {
				alert(response.message);
			}
		})
		.error(function (response) {
			alert(response.message);
		});

		$scope.createEvent = function () {
			$scope.createEventError = "";

			if (!$scope.create_event_name) {
				$scope.createEventError = "Please enter event name!";
				$("#create_event_name").focus();
				return;
			}

			if (!$scope.create_event_date) {
				$scope.createEventError = "Please enter event date!";
				$("#create_event_date").focus();
				return;
			}

			$http.post("serv/createevent", {
				user_id: angular.fromJson(sessionStorage.userData).user_id,
				login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
				group_id: $routeParams.groupId,
				event_name: $scope.create_event_name,
				event_date: $scope.create_event_date
			})
			.success(function (response) {
				if (response.success) {
					$scope.events = response.data;
					$scope.eventsCount = $scope.groups.length;

					$scope.createEventError = "";
					$scope.create_event_name = "";
				} else {
					$scope.createEventError = response.message;
				}
			})
			.error(function (response) {
				$scope.createEventError = response.message;
			});
		};

	});
}]);

myApp.controller("DatesController", ["$rootScope", "$scope", "$location", "AuthCheckService", function ($rootScope, $scope, $location, AuthCheckService) {
	$rootScope.pageTitle = "Dates";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {
		
	});
}]);
