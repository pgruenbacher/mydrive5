'use strict'

angular.module 'mydrive5App'
.factory 'Posts', ($http)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  all:()-> 
    $http.get '/api/posts'

  get:(id)->
    $http.get '/api/posts/'+id
