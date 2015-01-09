'use strict'

angular.module 'mydrive5App'
.directive 'myDate', ->
  restrict: 'EA'
  template: '<time datetime="2014-09-20" class="icon">
              <em>Saturday</em>
              <strong>September</strong>
              <span>20</span>
            </time>'
  link: (scope, element, attrs) ->

