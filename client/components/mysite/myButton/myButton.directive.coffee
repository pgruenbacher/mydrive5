'use strict'

angular.module 'mydrive5App'
.controller 'buttonModalCtrl',($scope,button,Sites)->
  $scope.available=Sites.getNavigationItems()
  $scope.button=button
  $scope.disable=(bool)->
    $scope.button.disabled=bool
  $scope.setDestination=(dest)->
    $scope.button.destination=dest

.directive 'myButton', ($location,config,Sites,$modal)->
  templateUrl: 'components/mysite/myButton/myButton.html'
  restrict: 'E'
  scope:
    button:'='
    currentPage:'@'
  link: (scope, element, attrs) ->
    
    scope.navigate=()->
      if scope.button.destination?
        path=$location.path()
        pos=path.search(scope.currentPage)
        path=path.slice(0,pos)+scope.button.destination
        $location.path(path)

    scope.visible=true
    defaultTitle='nav button'
    if config.public()
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
        modalInstance=$modal.open
          templateUrl:'app/admin/modals/myButtonModal.html'
          size:'sm'
          controller:'buttonModalCtrl'
          resolve:
            button:->
              scope.button
            available:->
              scope.available


      

