myApp.controller("GroupsController", ["$rootScope", "$scope", "$location", "$http", "AuthCheckService", function ($rootScope, $scope, $location, $http, AuthCheckService) {
	$rootScope.pageTitle = "Groups";

	AuthCheckService.checkLogin({ $rootScope: $rootScope, $scope: $scope, $location: $location }, function () {

		/*
		*	Load user's groups
		*/
		$http.post("serv/getgroups", {
			user_id: angular.fromJson(sessionStorage.userData).user_id,
			login_session_id: angular.fromJson(sessionStorage.userData).login_session_id
		})
		.success(function (response) {
			if (response.success){
				$scope.groups = response.data;
				$scope.groupsCount = $scope.groups.length;
			} else {
				alert(response.message);
			}
		})
		.error(function (response) {
			alert(response.message);
		});

		/*
		*	Creating a user group
		*/
		$scope.createGroup = function () {

			$scope.createGroupError = "";

			if (!$scope.create_group_name) {
				$scope.createGroupError = "Please enter group name!";
				$("#create_group_name").focus();
				return;
			}

			$http.post("serv/creategroup", {
				user_id: angular.fromJson(sessionStorage.userData).user_id,
				login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
				group_name: $scope.create_group_name,
				group_star: ($scope.create_group_star ? "Y" : "N")
			})
			.success(function (response) {
				if (response.success) {
					$scope.groups = response.data;
					$scope.groupsCount = $scope.groups.length;

					$scope.createGroupError = "";
					$scope.create_group_name = "";
				} else {
					$scope.createGroupError = response.message;
				}
			})
			.error(function (response) {
				$scope.createGroupError = response.message;
			});
		};

		/*
		*	Deleting a user group
		*/
		$scope.askDeleteGroup = function (group) {
			$scope.delete_group_data = group;
			$scope.delete_group_name = group.group_name;
		}
		$scope.doDeleteGroup = function () {
			var group = $scope.delete_group_data;

			$http.post("serv/deletegroup", {
				user_id: angular.fromJson(sessionStorage.userData).user_id,
				login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
				group_id: group.group_id
			})
			.success(function (response) {
				$("#deleteGroupModal").modal("hide");

				if (response.success) {
					
					// Delete it from the array also
					for (var a = 0; a < $scope.groups.length; a++) {
						if ($scope.groups[a].group_id == group.group_id) {
							$scope.groups.splice(a, 1);
							break;
						}
					}
					
					$scope.groupsCount--;
					$("#tblGroups [data-id='" + group.group_id + "']").animate({ height: "hide", opacity: "hide" }, "slow");
				} else {
					alert(response.message);
				}
			})
			.error(function (response) {
				alert(response.message);
			});
		};

		$scope.askEditGroup = function (group) {
			$scope.edit_group_data = group;
			$scope.edit_original_group_name = group.group_name;
			$scope.edit_group_name = group.group_name;
			$scope.edit_group_star = (group.starred == "Y" ? true : false);
		};

		$scope.doEditGroup = function (group) {
			var group = $scope.edit_group_data;

			$http.post("serv/editgroup", {
				user_id: angular.fromJson(sessionStorage.userData).user_id,
				login_session_id: angular.fromJson(sessionStorage.userData).login_session_id,
				group_id: group.group_id,
				group_name: $scope.edit_group_name,
				group_star: ($scope.edit_group_star ? "Y" : "N")
			})
			.success(function (response) {

				if (response.success) {
					$scope.groups = response.data;
					$scope.groupsCount = $scope.groups.length;

					$scope.editGroupError = "";
					$("#editGroupModal").modal("hide");
				} else {
					$scope.editGroupError = response.message;
				}
			})
			.error(function (response) {
				$scope.editGroupError = response.message;
			});
		};

	});
}]);
