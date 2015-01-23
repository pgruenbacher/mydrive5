'use strict'

angular.module 'mydrive5App'
.directive 'myErrors',()->
  templateUrl:'components/mysite/myForm/errors/errors.html'
  restrict:'E'
  transclude:true
  scope:
    field:'='
    form:'='
  link:()->
    if


.directive 'myField',($http,$compile,$templateCache,config,CONFIG,BROWSER)->
  restrict:'EA'
  scope:
    field:'='
    data:'='
  link:(scope,element,attrs)->
    scope.browser={
      supportsDate:BROWSER.inputtypes.date
      supportsDateTime:BROWSER.inputtypes.dateTime
      supportsTime:BROWSER.inputtypes.time
    }


    newScope=null
    newElement=null
    loadField=(template)->
      if newScope
        # IMPORTANT! DESTROY TO PREVENT MEMORY LEAKS LEAKS MEMORY 
        newScope.$destroy()
        newElement.remove() 
      newScope=scope.$new()
      element.html(template).show()
      newElement=$compile(element.contents())(newScope)
    
    getField=(templateName)->
      key="components/mysite/myForm/fieldTemplates/"+scope.field.type+".html"
      template=$templateCache.get key
      if template && CONFIG.public
        loadField(template)
      else
        $http.get key
        .then (response)->
          if response.data.length > 0
            loadField response.data
    if scope.field?
      if scope.field.type?        
        getField scope.field.type

    scope.$watch 'field', (newValue,oldValue)->
      if typeof newValue != 'undefined'
        if typeof newValue.type !='undefined'
          if oldValue != newValue
            getField scope.field.type

    scope.opened=true
    scope.open=($event)->
      console.log $event
      # $event.preventDefault()
      # $event.stopPropogation
      scope.opened=true
      console.log scope.opened



.directive 'myForm', ->
  templateUrl: 'components/mysite/myForm/myForm.html'
  restrict: 'EA'
  scope:
    fields:'='
  link: (scope, element, attrs) ->
    scope.data={}







  