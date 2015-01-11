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
      columns:[{class:'col-sm-4',sections:[]},{class:'col-sm-4',sections:[]},{class:'col-sm-4',sections:[]}]}
      {label:'3-3-3'
      columns:[{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]}]}
    ]


.directive 'myColumn',->
  restrict:'EA'
  templateUrl:'components/mysite/myRow/myColumn.html'
  scope:
    sections:'='
  link:(scope,element,attrs)->
    scope.addSection=->
      scope.sections.push
        section:{}

.directive 'myGrid',->
  restrict:'EA'
  templateUrl:'components/mysite/myRow/myGrid.html'
  scope:
    rows:'='
  link:(scope,element,attrs)->
    console.log scope.rows
    scope.addRow=->
      scope.rows.push
        columns:[]

.directive 'mySection',->
  restrict:'EA'
  templateUrl:'components/mysite/myRow/mySection.html'
  scope:
    section:'='
  link:(scope,element,attrs)->
    scope.chooseSection=->

    