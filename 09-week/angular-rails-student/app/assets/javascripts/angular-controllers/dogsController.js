angular.module('dogApp')
  .controller('DogsController', DogsController);

  DogsController.$inject = ['$http','$routeParams', '$window'];

  function DogsController($http, $routeParams, $window){
    var self = this;
    self.dogs = "It's working!!!";
  
  }