'use strict'

angular.module 'mydrive5App'
.factory 'Images', ($http)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  # Creates record, not upload!
  create:(data)->
    $http.post '/api/images', data

  splashes:()->
    $http.get '/api/images/splash'

  all:()->
    $http.get '/api/images'
