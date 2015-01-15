'use strict'

angular.module 'mydrive5App'
.controller 'SiteCtrl', ($scope,Sites,site,$stateParams,$location,$state,$anchorScroll) ->
  $scope.site=site
  Sites.setNavigationItems($scope.site)
  $scope.goTo=(slug)->
    console.log 'asdf'
    $state.go('app.admin.sites.site.page',{page:slug})

  

