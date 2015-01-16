'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.admin',
    url: '/admin'
    templateUrl: 'app/admin/admin.html'
    controller: 'AdminCtrl'
    ncyBreadcrumb:
      label:'Admin'
