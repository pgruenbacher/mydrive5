'use strict'

angular.module 'mydrive5App'
.controller 'DataCtrl', ($scope,$window,$http) ->
  
  $scope.loginOauth = (provider) ->
    $http.get 'api/data/subscribers/google'
    .then (response)->
      console.log response.status
    , (error)->
      console.log error
      if error.status == 409
        $window.location.href='/auth/google/drive'
  