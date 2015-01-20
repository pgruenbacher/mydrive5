'use strict'

angular.module 'mydrive5App'
.controller 'SiteCtrl', ($scope,Sites,site,$stateParams,$location,$state,$anchorScroll,$sce) ->
  $scope.site=site
  Sites.setNavigationItems($scope.site)

  $scope.site.fullDomain=$sce.trustAsResourceUrl 'http://'+site.domainName+'.mydrive5.com'
  $scope.goTo=(slug)->
    $state.go('app.admin.sites.site.page',{page:slug})

  

