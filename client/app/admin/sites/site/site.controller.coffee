'use strict'

angular.module 'mydrive5App'
.controller 'SiteCtrl', ($scope,Sites,site,$stateParams,$location,$state) ->
  $scope.site=site
  $scope.navigationItems=[]
  
  getNavigationItems=(site)->
    for menuItem in site.menuItems
      if menuItem.sub.length
        for subItem in menuItem.sub
          $scope.navigationItems.push subItem.slug
      else
        $scope.navigationItems.push menuItem.slug

  getNavigationItems($scope.site)
  console.log $scope.navigationItems

  $scope.goTo=(slug)->
    $state.go('app.admin.sites.site.page',{page:slug})

  

