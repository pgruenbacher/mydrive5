'use strict'

angular.module 'mydrive5App'
.directive 'myNavbar', ($state)->
  templateUrl: 'components/mysite/myNavbar/myNavbar.html'
  restrict: 'E'
  scope:
    navItems:'='
    navBrand:'@'
    customColor:'&'
    goTo:'&navClick'
  link: (scope, element, attrs) ->
    