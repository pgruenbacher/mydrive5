'use strict'

angular.module 'mydrive5App'
.controller 'NavbarCtrl', ($scope, Auth,$state) ->
  $scope.menu = [
    title: 'Home'
    state: 'app.main'
  ]
  $scope.isCollapsed = true
  $scope.isLoggedIn = Auth.isLoggedIn
  $scope.isAdmin = Auth.isAdmin
  $scope.getCurrentUser = Auth.getCurrentUser
  $scope.stateIncludes = (key)->
    $state.includes key
  $scope.isAdminAndNotState=->
    Auth.isAdmin() && !$scope.stateIncludes('app.admin')



