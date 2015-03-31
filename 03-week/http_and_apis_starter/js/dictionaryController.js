angular.module('dictionaryApp')
  .controller("DictionaryController", DictionaryController);

DictionaryController.$inject = ['$http'];

function DictionaryController($http) {
  var self = this;

  var targetUrl;
}