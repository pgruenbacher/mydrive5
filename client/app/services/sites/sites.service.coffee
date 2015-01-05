'use strict'

angular.module 'mydrive5App'
.factory 'Sites', ($http)->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  query:(obj)-> 
    $http.get '/api/sites/find', {params:obj}

  update:(id,obj)->
    console.log obj
    $http.put '/api/sites/'+id, obj

  set:(id,page)->
    console.log id,page
    $http.put '/api/sites/'+id+'/set',page
