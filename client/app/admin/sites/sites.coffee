'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.admin.sites',
    url: '/sites'
    templateUrl: 'app/admin/sites/sites.html'
    controller: 'SitesCtrl'
