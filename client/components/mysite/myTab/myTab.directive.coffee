'use strict'

angular.module 'mydrive5App'
.directive 'myTab', (config)->
  templateUrl: 'components/mysite/myTab/myTab.html'
  restrict: 'EA'
  scope:
    tabs:'=tabs'
  link: (scope, element, attrs) ->
    scope.editable=!config.public
    scope.$on('$desroy', ->
      console.log 'destroyed'
      )
    scope.newTab=->
      scope.tabs.push
        title:'New Tab'
        content:'<p>New content</p>'

    scope.deleteTab=(index)->
      scope.tabs.splice(index,1)
