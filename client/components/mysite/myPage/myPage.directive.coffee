'use strict'

angular.module 'mydrive5App'
.directive 'myPage', ($http,$compile,$templateCache)->
  restrict: 'EA',
  scope:
    template:'@'
    page:'='
    navigationItems:'='
  link: (scope, element, attrs) ->
    console.log 'link'
    newScope=null
    newElement=null
    
    loadTemplate=(template)->
      if newScope
        # IMPORTANT! DESTROY TO PREVENT MEMORY LEAKS LEAKS MEMORY 
        newScope.$destroy()
        newElement.remove() 
      newScope=scope.$new()
      element.html(template).show()
      newElement=$compile(element.contents())(newScope)
    
    $templateCache.put("components/mysite/myPage/templates/layouts/defaultLayout.html",'<div my-image=page.template.default.jumboImage background=true class="jumbo masthead my-image"><div class=container><editor-container><div editable=editorOptions ng-model=page.template.default.header1></div></editor-container></div></div><div class=container-fluid><div class=row><div class=col-md-4><div my-image=page.template.default.image1 class="my-image img-circle"><img ng-src={{page.template.default.image1.urlPath}} class="img-circle img-responsive"></div><editor-container><div editable=editorOptions ng-model=page.template.default.block1></div></editor-container><p><my-button button=page.template.default.button1 current-page={{page.slug}}></my-button></p></div><div class=col-md-4><div my-image=page.template.default.image2 class="my-image img-circle"><img ng-src={{page.template.default.image2.urlPath}} class="img-circle img-responsive"></div><editor-container><div editable=editorOptions ng-model=page.template.default.block2></div></editor-container><p><my-button button=page.template.default.button2 current-page={{page.slug}}></my-button></p></div><div class=col-md-4><div my-image=page.template.default.image3 class="my-image img-circle"><img ng-src={{page.template.default.image3.urlPath}} class="img-circle img-responsive"></div><editor-container><div editable=editorOptions ng-model=page.template.default.block3></div></editor-container><p><my-button button=page.template.default.button3 current-page={{page.slug}}></my-button></p></div></div><div class=row><subscription-form></subscription-form></div></div>')

    getTemplate=(templateName)->
      key="components/mysite/myPage/templates/layouts/"+scope.template+".html"
      template=$templateCache.get key
      console.log 'template',template, scope.template
      if template
        loadTemplate(template)
      else
        $http.get key
        .then (response)->
          if response.data.length > 0
            loadTemplate response.data

    
    element.text 'Loading...'
    getTemplate(scope.template)

    oldTemplate=scope.template
    attrs.$observe 'template', (newValue)->
      if oldTemplate != newValue
        getTemplate scope.template
      oldTemplate=newValue

  controller:($scope)->
    $scope.editorOptions =
      language: 'en'
      'skin': 'moono'
      extraPlugins: 'imagebrowser,mediaembed,sourcedialog,colorbutton,SimpleLink,iframe,colordialog,youtube'
      imageBrowser_listUrl: '/api/images?type=editorBrowser'
      filebrowserBrowseUrl: '/api/files?type=editorBrowser'
      filebrowserImageUploadUrl: '/api/images/upload'
      filebrowserUploadUrl: '/api/files/upload'
      # toolbarLocation: 'bottom'
      toolbar: 'full'
      toolbar_full: [
        name: 'basicstyles'
        items: [ 'Bold', 'Italic', 'Underline' ]
      ,   
        name: 'paragraph'
        items: [ 'BulletedList', 'NumberedList', 'Blockquote' ]
      ,
        name: 'editing' 
        items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ]
      ,
        name:'document'
        items: ['Sourcedialog']
      ,
        name: 'links'
        items: [ 'Link' , 'Unlink', 'Iframe']
      ,
        name:'colors'
        items:['TextColor','BGColor']
      ,
      '/'
      ,
        name: 'tools'
        items: [ 'SpellChecker', 'Maximize' ]
      ,
        name: 'clipboard'
        items: [ 'Undo', 'Redo' ]
      ,
        name: 'styles'
        items: [ 'Format', 'PasteText', 'PasteFromWord', 'RemoveFormat' ]
      ,
        name: 'insert'
        items: [ 'Image', 'Table', 'SpecialChar', 'MediaEmbed','Youtube' ]
      ]
