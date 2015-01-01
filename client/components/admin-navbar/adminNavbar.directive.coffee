'use strict'

angular.module 'mydrive5App'
.directive 'adminNavbar', ->
  templateUrl: 'components/admin-navbar/adminNavbar.html'
  restrict: 'EA'
  link: (scope, element, attrs) ->
