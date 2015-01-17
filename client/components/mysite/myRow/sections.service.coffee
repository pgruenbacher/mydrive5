angular.module 'mydrive5App'
.factory 'Columns', ()->
  templates:[
      {label:'4-4-4'
      columns:[{class:'col-sm-4',sections:[]},{class:'col-sm-4',sections:[]},{class:'col-sm-4',sections:[]}]}
      {label:'3-3-3-3'
      columns:[{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]},{class:'col-sm-3',sections:[]}]}
      {
        label:'1'
        columns:[{class:'col-sm-12',sections:[]}]
      }
    ]
.factory 'Sections', ()->
  templates:[
      {
        block:'<p>Placeholder Text</p>'
        label:'text box'
        html:'<editor-container><div editable="editorOptions" ng-model="section.template.block"></div></editor-container>'
      }
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
        html:'<div class="jumbo masthead my-image" style="margin-left:-15px;margin-right:-15px;" 
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