'use strict'

angular.module 'mydrive5App'
.controller 'buttonModalCtrl',($scope,button,available,forms)->
  $scope.available=available
  $scope.button=button
  $scope.forms=forms
  $scope.selected=''
  $scope.disable=(bool)->
    $scope.button.disabled=bool
  $scope.setDestination=(dest)->
    $scope.button.perform=dest
    $scope.button.performType='navigation'
  $scope.setForm=(action)->
    $scope.button.perform=action
    $scope.button.performType='form'

  $scope.select=(option)->
    $scope.selected=option

.directive 'myButton', ($location,config,Sites,$modal,Forms)->
  templateUrl: 'components/mysite/myButton/myButton.html'
  restrict: 'E'
  scope:
    button:'='
    currentPage:'@'
  link: (scope, element, attrs) ->
    
    scope.perform=()->
      'perform'
      switch scope.button.performType
        when 'navigation'
          path=$location.path()
          pos=path.search(scope.currentPage)
          path=path.slice(0,pos)+scope.button.perform
          $location.path(path)
        when 'form'
          console.log 'is form'
          $modal.open
            templateUrl:'components/mysite/myForm/myFormModal.html'
            controller:'myFormModalCtrl'
            size:'sm'
            resolve:
              form:->
                Forms.get(scope.button.perform).then (response)->
                  response.data


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
          size:'lg'
          controller:'buttonModalCtrl'
          resolve:
            button:->
              scope.button
            available:->
              Sites.getNavigationItems()
            forms:->
              Forms.cacheCall().then (response)->
                response.data


      

