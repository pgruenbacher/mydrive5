'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider
  .state 'app.admin.sites',
    abstract:true
    url: '/sites'
    template:'<ui-view></ui-view>'

  .state 'app.admin.sites.index',
    url:''
    templateUrl:'app/admin/sites/sites.html'
    controller:'SitesCtrl'
