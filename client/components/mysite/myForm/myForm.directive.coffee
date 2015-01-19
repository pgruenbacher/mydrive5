'use strict'

angular.module 'mydrive5App'
.directive 'myField',($http,$compile,$templateCache,config,CONFIG,BROWSER)->
  restrict:'EA'
  scope:
    field:'='
    data:'='
  require:'^form'
  link:(scope,element,attrs,myForm)->
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

    getField scope.field.type

    scope.$watch 'field', (newValue,oldValue)->
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
  link: (scope, element, attrs) ->
    scope.data=[{},{},{},{},{}]
    scope.fields=[
      {
        id:1
        type:'checkbox'
        name:'checkbox'
        label:'checkbox demo'
        required:true
      }
      {
        id:2
        type:'options'
        name:'asdfff'
        label:'options demo'
        options:[
          {name:'asdf',value:'asdfl'}
          {name:'sabba',value:'ablkj'}
        ]
        required:true
        placeholder:'pick option'
      }
      {
        id:3
        type:'date'
        name:'datepick'
        date:new Date()
        label:'date example'
        format:'MM.dd.YYYY'
        placeholder:'pibck date'
      }
      {
        id:4
        type:'textarea'
        name:'asbb'
        label:'text example'
        required:true
        placeholder:'adsflkj placehold'
      }

    ]
