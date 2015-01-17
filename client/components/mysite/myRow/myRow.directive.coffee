'use strict'

angular.module 'mydrive5App'

.directive 'myRow', (config,Columns,$modal)->
  restrict: 'EA'
  templateUrl:'components/mysite/myRow/myRow.html'
  transclude:true
  scope:
    row:'='
  link: (scope, element, attrs) ->
    scope.editable = !config.public()
    scope.templates=Columns.templates
    console.log scope.row.template == 'undefined'
    if typeof scope.row.label == 'undefined'
      scope.row.template=Columns.templates[0]
    scope.changeColumns=->
      saved=scope.row
      modalInstance=$modal.open
        templateUrl:'app/admin/sites/site/page/templatesModal.html'
        controller:'layoutCtrl'
        size:'lg'
        resolve:
          service:->
            'Columns'
          selected:->
            scope.row
      modalInstance.result.then null, (rejection)->
        console.log scope.row
        scope.row=saved



.directive 'myColumn',(config,Sections,$modal)->
  restrict:'EA'
  templateUrl:'components/mysite/myRow/myColumn.html'
  scope:
    sections:'='
  link:(scope,element,attrs)->
    scope.addSection=->
      scope.sections.push
        template:Sections.templates[0]
    scope.editable = !config.public()
    # scope.sectionTemplates = Sections.templates
    scope.deleteSection=(index)->
      scope.sections.splice(index,1)
    scope.changeSection=(index)->
      saved=scope.sections[index].template
      modalInstance=$modal.open
        templateUrl:'app/admin/sites/site/page/templatesModal.html'
        controller:'layoutCtrl'
        size:'lg'
        resolve:
          service:->
            'Sections'
          selected:->
            scope.sections[index]
      modalInstance.result.then null, (rejection)->
        scope.sections[index].template=saved


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
        template:{}
    if typeof scope.grid.rows[0] == 'undefined'
      console.log 'add'
      scope.addRow()

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

    