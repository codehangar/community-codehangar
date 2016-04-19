(function() {
  'use strict';

  angular
    .module('community.codehangar')
    .controller('LadiesCtrl', LadiesCtrl);

  function LadiesCtrl($scope, $timeout, $http, $window, $state, $location) {

    $scope.init = function() {
      console.log('Hello LadiesCtrl')
    };
    $scope.init();
  }
})();
