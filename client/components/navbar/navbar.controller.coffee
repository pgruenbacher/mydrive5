'use strict'

angular.module 'mydrive5App'
.controller 'NavbarCtrl', ($scope, Auth,$state) ->
  $scope.menu = [
    title: 'Home'
    state: 'app.main'
  ]
  $scope.isCollapsed = true
  $scope.isLoggedIn = Auth.isLoggedIn
  $scope.isAdmin = Auth.isAdmin
  $scope.getCurrentUser = Auth.getCurrentUser
  $scope.stateIncludes = (key)->
    $state.includes key
  $scope.isAdminAndNotState=->
    Auth.isAdmin() && !$scope.stateIncludes('app.admin')

.directive 'navbar', ($state,Auth,$document)->
  templateUrl: 'components/navbar/navbar.html'
  restrict: 'E'
  link: (scope, element, attrs) ->
    scope.isCollapsed = true
    scope.isLoggedIn = Auth.isLoggedIn
    scope.isAdmin = Auth.isAdmin
    scope.getCurrentUser = Auth.getCurrentUser
    scope.stateIncludes = (key)->
      $state.includes key
    scope.isAdminAndNotState=->
      Auth.isAdmin() && !scope.stateIncludes('app.admin')
    elementMatchesAnyInArray=(element,elementArray)->
      for item in elementArray
        if element == item
          return true
      return false
    $document.bind 'click', (event)->
      if !elementMatchesAnyInArray(event.target, element.find(event.target.tagName))
        if scope.isCollapsed==false
          scope.isCollapsed=true
          scope.$apply()



