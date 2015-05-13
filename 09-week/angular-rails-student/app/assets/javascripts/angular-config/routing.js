angular.module('dogApp')
  .config(['$routeProvider',config]);

function config($routeProvider){
  $routeProvider
  .when('/',{
    templateUrl: "index.html",
    controller: "DogsController",
    controllerAs: "dogsCtrl"
    })
  .otherwise({
    redirectTo: '/'
  });
}