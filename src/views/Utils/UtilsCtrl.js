(function() {
  'use strict';

  angular
    .module('community.codehangar')
    .controller('UtilsCtrl', UtilsCtrl);

  function UtilsCtrl($scope, $timeout, $http, $window, $state, $location) {

    $scope.init = function() {
      console.log('Hello UtilsCtrl')
    };
    $scope.init();
  }
})();
