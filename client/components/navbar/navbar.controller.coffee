'use strict'

angular.module 'mydrive5App'
.controller 'NavbarCtrl', ($scope, Auth) ->
  $scope.menu = [
    title: 'Home'
    state: 'app.main'
  ]
  $scope.isCollapsed = true
  $scope.isLoggedIn = Auth.isLoggedIn
  $scope.isAdmin = Auth.isAdmin
  $scope.getCurrentUser = Auth.getCurrentUser

  console.log Auth.getCurrentUser