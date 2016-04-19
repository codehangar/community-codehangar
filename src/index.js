(function () {
  'use strict';

  angular
    .module('community.codehangar', [
      'ui.router',
      'ui.bootstrap'
    ]);

  angular
    .module('community.codehangar')
    .run(function ($http) {
      $http.defaults.headers.common['Content-Type'] = 'application/json';
    });
})();