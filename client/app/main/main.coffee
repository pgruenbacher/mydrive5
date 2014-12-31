'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.main',
    url: '/'
    templateUrl: 'app/main/main.html'
    controller: 'MainCtrl'
