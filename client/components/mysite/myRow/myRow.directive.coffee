'use strict'

angular.module 'mydrive5App'

.directive 'myRow', (config,Columns)->
  restrict: 'EA'
  templateUrl:'components/mysite/myRow/myRow.html'
  transclude:true
  scope:
    row:'='
  link: (scope, element, attrs) ->
    scope.editable = !config.public()
    scope.templates=Columns.templates


.directive 'myColumn',(config,Sections,$modal)->
  restrict:'EA'
  templateUrl:'components/mysite/myRow/myColumn.html'
  scope:
    sections:'='
  link:(scope,element,attrs)->
    scope.addSection=->
      scope.sections.push
        section:{}
    scope.editable = !config.public()
    scope.sectionTemplates = Sections.templates
    scope.changeSection=(index)->
      modalInstance=$modal.open
        templateUrl:'app/admin/sites/site/page/templatesModal.html'
        controller:'layoutCtrl'
        size:'lg'
        resolve:
          service:->
            'Sections'
          selected:->
            scope.sections[index]
      modalInstance.result.then (result)->
        scope.sections[index].template = result


.directive 'myGrid',(config)->
  restrict:'EA'
  templateUrl:'components/mysite/myRow/myGrid.html'
  scope:
    grid:'='
  link:(scope,element,attrs)->
    scope.editable=!config.public()
    scope.deleteRow=(index)->
      scope.grid.rows.splice(index,1)
    scope.addRow=->
      scope.grid.rows.push
        columns:[]

.directive 'mySection',($compile)->
  restrict:'EA'
  scope:
    section:'='
  link:(scope,element,attrs)->
    newScope=null
    newElement=null
    scope.$watch 'section.template',(newValue,oldValue)->
      if newValue?
        if newValue.html
          if newScope
            # IMPORTANT! DESTROY TO PREVENT MEMORY LEAKS LEAKS MEMORY 
            newScope.$destroy()
            newElement.remove() 
          newScope=scope.$new()
          element.html(newValue.html).show()
          newElement=$compile(element.contents())(newScope)

    