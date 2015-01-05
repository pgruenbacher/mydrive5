'use strict'

# USING THE BOWER COMPONENT FOR HTE MOMENT!!!!!

angular.module 'mydrive5App'
# directive for compiling html


# .directive "compileHtml", ($parse, $sce, $compile)->
#   restrict: "A"
#   scope:
#     'message':'=compileHtml'
#   link: (scope, element, attributes)->
#     expression = $sce.trustAsHtml(scope.message).toString()
#     element.append expression



# .directive 'editorContainer', ->
#   template:"<div class='editor-container'>"+
#     "<div class='editor-vline right'></div>"+
#     "<div class='editor-vline'></div>"+
#     "<div class='editor-hline bottom'></div>"+
#     "<div class='editor-hline'></div>"+
#     "<div ng-transclude='true'></div>"+
#     "</div>"
#   transclude:true
#   restrict:'EA'
#   scope:true
#   link: (scope,element,attrs)->



# # directive for the CKE editor
# .directive 'ckedit', ($parse)->
  
#   CKEDITOR.disableAutoInline = true
#   counter = 0
#   prefix = '__ckd_'
  

#   template: '<div></div>'
#   restrict: 'EA'
#   link: (scope, element, attrs) ->
#     getter = $parse(attrs.ckedit)
#     setter = getter.assign;

#     attrs.$set 'contenteditable', true
#     if !attrs.id
#       attrs.$set 'id', prefix + (++counter)


#     CKEDITOR.plugins.registered['save'] =
#       init:(editor)->
#         editor.addCommand 'save',
#           modes: { wysiwyg: 1, source: 1 },
#           exec: (editor)->
#             if (editor.checkDirty())
#               ckValue = editor.getData()
#               scope.$apply ->
#                 setter(scope, ckValue)
#               ckValue = null
#               editor.resetDirty()
#         editor.ui.addButton 'Save',
#           label: 'Save'
#           command: 'save'
#           toolbar: 'document'
    
#     options = {}
#     options.on =
#       blur: (e) ->
#         if (e.editor.checkDirty())
#           ckValue = e.editor.getData()
#           scope.$apply ->
#             setter(scope, ckValue)
#           ckValue = null
#           e.editor.resetDirty()

#     options.extraPlugins = 'sourcedialog'
#     options.removePlugins = 'sourcearea'
#     editorangular = CKEDITOR.inline element[0], options

#     scope.$watch attrs.ckedit, (value)->
#       editorangular.setData(value)


# .run ($q, $timeout)->
#   $defer = $q.defer()

#   if (angular.isUndefined(CKEDITOR))
#     throw new Error('CKEDITOR not found')

#   CKEDITOR.disableAutoInline = true;
#   checkLoaded=()->
#     if (CKEDITOR.status == 'loaded')
#       loaded = true;
#       $defer.resolve();
#     else
#       checkLoaded()
#   CKEDITOR.on('loaded', checkLoaded)
#   $timeout(checkLoaded, 100)


.directive 'editable',($timeout, $q)->
  restrict: 'A'
  require: ['ngModel', '^?form']
  scope:
    editableOptions:'=editable'
  link: (scope, element, attrs, ctrls)->
    ngModel = ctrls[0]
    form    = ctrls[1] || null
    EMPTY_HTML = '<p></p>'
    isTextarea = element[0].tagName.toLowerCase() == 'textarea'
    data = []
    isReady = false

    if !isTextarea
      element.attr('contenteditable', true)

    onLoad = ()->
      options =
        toolbar: 'full'
        disableNativeSpellChecker: false,
        uiColor: '#FAFAFA'
        height: '400px'
        width: '100%'

      options = angular.extend(options, scope.editableOptions);

      instance = if isTextarea then CKEDITOR.replace(element[0], options) else CKEDITOR.inline(element[0], options)
      configLoaderDef = $q.defer();

      element.bind '$destroy', ()->
        instance.destroy(false)
        data=[]
          # false If the instance is replacing a DOM element, this parameter indicates whether or not to update the element with the instance contents.
         
      setModelData = (setPristine)->
        data = instance.getData();
        if data == ''
          data = null
       
        # for key up event
        $timeout(()-> 
          (setPristine != true || data != ngModel.$viewValue) && ngModel.$setViewValue(data)
          (setPristine == true && form) && form.$setPristine()
        , 0)
      onUpdateModelData = (setPristine)->
        if !data.length  
          return

        item = data.pop() || EMPTY_HTML
        isReady = false
        instance.setData item, ()->
          setModelData(setPristine)
          isReady = true

      # instance.on('pasteState', setModelData);
      instance.on('change', setModelData)
      instance.on('blur', setModelData)
      instance.on 'instanceReady', ( ev )->
        editor = ev.editor;
        editor.setReadOnly( false );
      # instance.on('key',  setModelData); // for source view

      instance.on 'instanceReady', ()->
        scope.$broadcast "ckeditor.ready"
        scope.$apply ()->
          onUpdateModelData(true);

        instance.document.on "keyup", setModelData

      instance.on 'customConfigLoaded', ()->
        configLoaderDef.resolve()

      ngModel.$render = ()->
        if typeof ngModel.$viewValue != 'undefined' && typeof data != 'undefined'
          data.push(ngModel.$viewValue)
          if isReady
            onUpdateModelData() 
      false

    if (CKEDITOR.status == 'loaded')
      loaded = true
    if (loaded)
      onLoad()
    else
      $defer.promise.then(onLoad)