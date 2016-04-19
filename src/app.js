console.log('webpack');

// FAVICONS & IMAGES
require.context('./components', true, /^\.\//);
require.context('./favicons', true, /^\.\//);
require.context('./views', true, /^\.\//);

// TEMPLATES
require.context('./', true, /\.html$/);


//CSS & SCSS
require("!style!css!sass!./index.scss");

//JS NODE_MODULES
require('../node_modules/angular/angular.js')
require('../node_modules/angular-ui-router/release/angular-ui-router.min.js')
require('../node_modules/angular-ui-bootstrap/index.js')

//JS APP SCRIPTS
require('./index.js')
require('./index.routes.js')

//JS VIEW CONTROLLERS
require('./views/Utils/UtilsCtrl.js')