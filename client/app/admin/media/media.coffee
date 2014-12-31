'use strict'

angular.module 'mydrive5App'
.config ($stateProvider) ->
  $stateProvider.state 'app.admin.media',
    url: '/media'
    templateUrl: 'app/admin/media/media.html'
    controller: 'mediaCtrl'
