(function () {
  'use strict';

  angular
    .module('utils.codehangar', [
      'ui.router',
      'ui.bootstrap'
    ]);

  angular
    .module('utils.codehangar')
    .run(function ($http) {
      $http.defaults.headers.common['Content-Type'] = 'application/json';
    });
})();