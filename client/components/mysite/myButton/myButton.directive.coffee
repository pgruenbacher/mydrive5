'use strict'

angular.module 'mydrive5App'
.directive 'myButton', ($location)->
  templateUrl: 'components/mysite/myButton/myButton.html'
  restrict: 'E'
  scope:
    available:'='
    button:'='
    currentPage:'@'
  link: (scope, element, attrs) ->

    if !scope.button.title?
      scope.button.title='nav button'

    scope.edit=(bool)->
      scope.editMode=bool
    scope.disable=(bool)->
      scope.button.disabled=bool
    scope.setDestination=(dest)->
      scope.button.destination=dest
    scope.navigate=()->
      if scope.button.destination? && !scope.editMode
        path=$location.path()
        pos=path.search(scope.currentPage)
        path=path.slice(0,pos)+scope.button.destination
        $location.path(path)


