'use strict'

angular.module 'mydrive5App'
.directive 'myPage', ($http,$compile)->
  restrict: 'EA',
  scope:
    template:'@'
    page:'='
    navigationItems:'='
  link: (scope, element, attrs) ->
    getTemplate=(templateName)->
      $http.get 'components/mysite/myPage/templates/layouts/'+scope.template+'.html'
      .then (response)->
        if response.data.length > 0
          element.html(response.data).show()
          $compile(element.contents())(scope)

    element.text 'Loading...'

    getTemplate(scope.template)

    oldScope=scope.template
    attrs.$observe 'template', (newValue)->
      if oldScope != newValue
        getTemplate scope.template
      oldScope=newValue

  controller:($scope)->
    $scope.newFaq=->
      $scope.page.template.faq.faqs.push
        title:'New Faq'
        content:'<p>New content</p>'

    $scope.deleteFaq=(index)->
      $scope.page.template.faq.faqs.splice(index,1)

    $scope.newTab=->
      $scope.page.template.eventInfo.schedules.push
        title:'New Tab'
        content:'<p>New content</p>'

    $scope.deleteTab=(index)->
      $scope.page.template.eventInfo.schedules.splice(index,1)

    $scope.editorOptions =
      language: 'en'
      'skin': 'moono'
      extraPlugins: 'imagebrowser,mediaembed,sourcedialog,colorbutton,SimpleLink,colordialog,youtube'
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
        items: [ 'Link' , 'Unlink',]
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
