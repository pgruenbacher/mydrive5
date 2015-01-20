'use strict'

angular.module 'mydrive5App'
.controller 'SiteSettingsCtrl', ($scope,site,Sites,Forms) ->
  $scope.site=site
  $scope.saveSite=()->
    console.log 'save'
    Sites.saveSite($scope.site._id,$scope.site)
    .then (response)->
      console.log response

