'use strict'

angular.module 'mydrive5App'
.factory 'Sites', ($http)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  query:(obj)-> 
    $http.get '/api/sites/find', {params:obj}
