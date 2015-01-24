'use strict'

angular.module 'mydrive5App'
.controller 'LoginCtrl', ($scope, Auth, $state, $window) ->
  $scope.user = {}
  $scope.errors = {}

  $scope.fields=
    email:
      name:'email'
      type:'email'
      label:'email'
      required:true
    password:
      name:'password'
      type:'password'
      label:'password'
      required:true

  $scope.login = (form) ->
    $scope.submitted = true

    if form.$valid
      # Logged in, redirect to home
      Auth.login
        email: $scope.user.email
        password: $scope.user.password

      .then ->
        $state.go 'app.admin'

      .catch (err) ->
        $scope.errors.other = err.message

  $scope.loginOauth = (provider) ->
    $window.location.href = '/auth/' + provider
