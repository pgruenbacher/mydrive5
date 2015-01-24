'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider.state 'app.admin.data',
    url: '/data'
    templateUrl: 'app/admin/data/data.html'
    controller: 'DataCtrl'
