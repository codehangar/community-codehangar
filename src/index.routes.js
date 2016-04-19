(function() {
  'use strict';

  angular
    .module('utils.codehangar')
    .config(routeConfig);

  /** @ngInject */
  function routeConfig($stateProvider, $urlRouterProvider, $locationProvider) {

    $urlRouterProvider.otherwise('/');

    $stateProvider
      .state('root', {
        url: '/',
        views: {
          'content': {
            templateUrl: 'views/Utils/Utils.html',
            controller: 'UtilsCtrl',
            controllerAs: 'UtilsCtrl'
          }
        }
      });

    $urlRouterProvider.rule(function($injector, $location) {
      var path = $location.url();
      // check to see if the path already has a slash where it should be
      if ('/' === path[path.length - 1] || path.indexOf('/?') > -1) {
        return;
      }
      if (path.indexOf('?') > -1) {
        return path.replace('?', '/?');
      }
      return path + '/';
    });

    $locationProvider.html5Mode(true);

  }

})();
