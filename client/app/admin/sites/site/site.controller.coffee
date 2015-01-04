'use strict'

angular.module 'mydrive5App'
.controller 'SiteCtrl', ($scope,Sites,site,$stateParams,$location,$state) ->
  $scope.site=site
  $scope.sdf='asdf'
  $scope.goTo=(slug)->
    $state.go('app.admin.sites.site.page',{page:slug})

  

