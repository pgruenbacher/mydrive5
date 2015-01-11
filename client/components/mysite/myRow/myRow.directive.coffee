'use strict'

angular.module 'mydrive5App'
.directive 'myRow', (config)->
  restrict: 'EA'
  templateUrl:'components/mysite/myRow/myRow.html'
  transclude:true
  scope:
    row:'='
  link: (scope, element, attrs) ->
    scope.editable = !config.public()
    scope.templates=[
      {label:'4-4-4'
      columns:[{class:'col-sm-4',sections:[]},{class:'col-sm-4',sections:[]},{class:'col-sm-4',sections:[]}]}
      {label:'3-3-3-3'
      columns:[{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]}]}
      {
        label:'1'
        columns:[{class:'col-sm-12',sections:[]}]
      }
    ]


.directive 'myColumn',(config)->
  restrict:'EA'
  templateUrl:'components/mysite/myRow/myColumn.html'
  scope:
    sections:'='
  link:(scope,element,attrs)->
    scope.addSection=->
      scope.sections.push
        section:{}
    scope.editable = !config.public()
    scope.sectionTemplates=[
      {
        label:'image'
        html:'<div class="my-image img-circle" my-image="section.image">
                <img ng-src="{{section.image.urlPath}}" class="img-circle img-responsive"/>
              </div>'
      }
      {
        label:'faq'
        faqs:[
          {title:'Fundraiser Questions',content:'<p>Placeholder</p>'}
          {title:'General Questions',content:'<p>Placeholder</p>'}
          {title:'Event Questions',content:'<p>Placeholder</p>'}
        ]
        html: '<my-faq faqs="section.template.faqs" editor-options="{{editorOptions}}"><my-faq>'
      }
      {
        block:'<p>Placeholder Text</p>'
        label:'text box'
        html:'<editor-container><div editable="editorOptions" ng-model="section.template.block"></div></editor-container>'
      }
      {
        label:'tabs'
        schedules:[
          {title:'Day 1',content:'<ul><li>Example List Day 1</li></ul>'}
          {title:'Day 2',content:'<ul><li>Example List Day 2</li></ul>'}
        ]
        html:'<my-tab editorOptions="editorOptions" tabs="section.template.schedules"></my-tab>'
      }
      {
        header:'<h1>Placeholder Header</h1>'
        label:'banner'
        html:'<div class="jumbo masthead my-image" 
                my-image="section.template.image"
                background="true">
                <editor-container>
                  <div editable="editorOptions" asf="{{section.template.header}}" ng-model="section.template.header">
                  </div>
                </editor-container>
              </div>'
      }
      {
        label:'action button'
        html:'<my-button 
          available="navigationItems"
          button="section.template.button"
          current-page="{{page.slug}}"></my-button>'
      }
    ]

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
      console.log newValue
      if newValue?
        if newValue.html
          if newScope
            # IMPORTANT! DESTROY TO PREVENT MEMORY LEAKS LEAKS MEMORY 
            newScope.$destroy()
            newElement.remove() 
          newScope=scope.$new()
          element.html(newValue.html).show()
          newElement=$compile(element.contents())(newScope)

    