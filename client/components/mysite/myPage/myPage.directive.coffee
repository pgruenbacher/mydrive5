'use strict'

angular.module 'mydrive5App'
.directive 'myPage', ($http,$compile)->
  restrict: 'EA',
  scope:
    template:'@'
    page:'='
    navigationItems:'='
  link: (scope, element, attrs) ->
    console.log 'link'
    newScope=null
    newElement=null

    getTemplate=(templateName)->
      $http.get 'components/mysite/myPage/templates/layouts/'+scope.template+'.html'
      .then (response)->
        if response.data.length > 0
          if newScope
            # IMPORTANT! DESTROY TO PREVENT MEMORY LEAKS LEAKS MEMORY 
            newScope.$destroy()
            newElement.remove() 
          newScope=scope.$new()
          element.html(response.data).show()
          newElement=$compile(element.contents())(newScope)

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
