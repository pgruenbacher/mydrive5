'use strict'

angular.module 'mydrive5App'
.directive 'myButton', ($location,config)->
  templateUrl: 'components/mysite/myButton/myButton.html'
  restrict: 'E'
  scope:
    available:'='
    button:'='
    currentPage:'@'
  link: (scope, element, attrs) ->
    scope.visible=true
    defaultTitle='nav button'
    if config.public
      scope.editing= false
      if typeof scope.button == 'undefined' || scope.button.disabled
        scope.visible=false
      else if typeof scope.button.title == 'undefined'
        scope.visible =false
      else if scope.button.title == defaultTitle
        scope.visible = false
    else
      scope.editing = true
      if typeof scope.button != 'undefined'
        if typeof scope.button.title =='undefined'
          scope.button.title='nav button'
        else if scope.button.title == null
          scope.button.title=defaultTitle
      else
        scope.button={title:defaultTitle}
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

