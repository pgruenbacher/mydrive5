'use strict'

angular.module 'mydrive5App'
.directive 'fullBlog', ->
  templateUrl: 'components/fullBlog/fullBlog.html'
  restrict: 'EA'
  scope:
    editorOptions:'='
    blog:'='
  link: (scope, element, attrs) ->
    console.log scope.blog

