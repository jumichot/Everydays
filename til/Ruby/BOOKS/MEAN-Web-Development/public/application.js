var mainApplicationModuleName = 'mean';
var mainApplicationModule = angular.module(mainApplicationModuleName, ['ngRoute','users', 'example']);

//use Hashbangs configuration http://localhost:3000/#!/example for seo purpose
mainApplicationModule.config(['$locationProvider',
  function($locationProvider){
    $locationProvider.hashPrefix('!');
  }
]);

// fix oauth redirect with facebook auth
if (window.location.hash === '#_=_') window.location.hash = '#!';

angular.element(document).ready(function(){
  angular.bootstrap(document, [mainApplicationModuleName]);
});
