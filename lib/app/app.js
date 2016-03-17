var myApp = angular.module("myApp", [
	"ngRoute"
]);

myApp.run(function ($rootScope) {
	$rootScope.appName = "MyCalendar Manager";
	$rootScope.url = "Hello World! How are you?"
});

myApp.filter("urlName", function () {
	return function (input) {
		return input.replace(/[^a-zA-Z 0-9]+/g, "")
			.replace(new RegExp(" ", "gi"), "-")
			.replace(/-+/gi, "-")
			.toLowerCase();
	};
});

myApp.filter('dateToISO', function () {
	return function (input) {
		try {
			return new Date(input).toISOString();
		} catch (e) {
			return '';
		}
	};
});

myApp.directive('escKey', function () {
	return function (scope, element, attrs) {
		element.bind('keydown keypress', function (event) {
			if(event.which === 27) {
				scope.$apply(function () {
					scope.$eval(attrs.escKey);
				});

				event.preventDefault();
			}
		});
	};
});

myApp.factory("AuthCheckService", function($http) {
	return {
		checkLogin: function ($params, callback) {
			if (sessionStorage.loggedIn) {
				$params.$scope.showHome = true;
				$params.$rootScope.login_first_name = angular.fromJson(sessionStorage.userData).first_name;

				$http.post("serv/checklogin", {
					user_id: angular.fromJson(sessionStorage.userData).user_id,
					login_session_id: angular.fromJson(sessionStorage.userData).login_session_id
				})
				.success(function (response) {
					if (response.success) {
						if (callback) {
							callback();
						}
					} else {
						delete sessionStorage.loggedIn;
						delete sessionStorage.userData;
						$params.$rootScope.showHome = false;
						$params.$rootScope.showNav = false;
						$params.$location.path("/login/session_timeout=1");
					}
				})
				.error(function (response) {
					alert(response.message);
				});
				
			} else {
				$params.$location.path("/login");
			}
		}
	}
});

myApp.config(["$routeProvider", function ($routeProvider) {
	$routeProvider
	.when("/login", {
		templateUrl: "partials/login.html",
		controller: "LoginController"
	})
	.when("/login/:params", {
		templateUrl: "partials/login.html",
		controller: "LoginController"
	})
	.when("/register", {
		templateUrl: "partials/register.html",
		controller: "RegisterUserController"
	})
	.when("/home", {
		templateUrl: "partials/home.html",
		controller: "HomeController"
	})
	.when("/groups", {
		templateUrl: "partials/groups.html",
		controller: "GroupsController"
	})
	.when("/group/:groupUrl/:groupId", {
		templateUrl: "partials/group.html",
		controller: "GroupController"
	})
	.when("/dates", {
		templateUrl: "partials/dates.html",
		controller: "DatesController"
	})
	.when("/settings", {
		templateUrl: "partials/settings.html",
		controller: "SettingsController"
	})
	.otherwise({
		redirectTo: "/home"
	});
}]);