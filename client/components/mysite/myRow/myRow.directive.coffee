'use strict'

angular.module 'mydrive5App'
.directive 'myRow', ->
  restrict: 'EA'
  templateUrl:'components/mysite/myRow/myRow.html'
  scope:
    columns:'='
  link: (scope, element, attrs) ->

    scope.templates=[
      {label:'4-4-4'
      columns:['col-sm-4','col-sm-4','col-sm-4']}
      {label:'3-3-3'
      columns:['col-sm-3','col-sm-3','col-sm-3','col-sm-3']}
    ]


.directive 'myColumn',->
  restrict:'EA'
  scope:
    rows:'='
  link:(scope,element,attrs)->


    