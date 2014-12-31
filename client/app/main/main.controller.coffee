'use strict'

angular.module 'mydrive5App'
.controller 'MainCtrl', ($scope, $http, socket) ->
  $scope.awesomeThings = []
  $scope.statistics=
    totalDonated:136000
    goal:200000
  $scope.editMode=true;
  $scope.exampleBody='<p>You can edit here</p>'

  $http.get('/api/things').success (awesomeThings) ->
    $scope.awesomeThings = awesomeThings
    socket.syncUpdates 'thing', $scope.awesomeThings

  $scope.addThing = ->
    return if $scope.newThing is ''
    $http.post '/api/things',
      name: $scope.newThing

    $scope.newThing = ''

  $scope.deleteThing = (thing) ->
    $http.delete '/api/things/' + thing._id

  $scope.$on '$destroy', ->
    socket.unsyncUpdates 'thing'


  $scope.editorOptions =
    language: 'en'
    'skin': 'moono'
    'extraPlugins': 'imagebrowser,mediaembed'
    imageBrowser_listUrl: '/api/images?type=editorBrowser'
    filebrowserBrowseUrl: '/api/files?type=editorBrowser'
    filebrowserImageUploadUrl: '/api/images/upload'
    filebrowserUploadUrl: '/api/files/upload'
    # toolbarLocation: 'bottom'
    toolbar: 'full'
    toolbar_full: [
      name: 'basicstyles'
      items: [ 'Bold', 'Italic', 'Strike', 'Underline' ]
    ,   
      name: 'paragraph'
      items: [ 'BulletedList', 'NumberedList', 'Blockquote' ]
    ,
      name: 'editing' 
      items: ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ]
    ,
      name: 'links'
      items: [ 'Link', 'Unlink', 'Anchor' ]
    ,
      name: 'tools'
      items: [ 'SpellChecker', 'Maximize' ]
    ,
      name: 'clipboard'
      items: [ 'Undo', 'Redo' ]
    ,
      name: 'styles'
      items: [ 'Format', 'FontSize', 'TextColor', 'PasteText', 'PasteFromWord', 'RemoveFormat' ]
    ,
      name: 'insert'
      items: [ 'Image', 'Table', 'SpecialChar', 'MediaEmbed' ]
    ,
      '/'
    ]
