'use strict'

angular.module 'mydrive5App'
.directive 'myImage', ($modal,config)->
  restrict: 'A'
  transclude:true
  scope:
    myImage:'='
  template:'<div ng-show="placehold" class="holder-text">Click to edit image (this placeholder won\'t appear on the website otherwise)</div><div ng-transclude></div>'
  link: (scope, element, attrs) ->
    if config.public
      if typeof scope.myImage == 'undefined'
        scope.myImage={urlPath:'//:0'}
      else if typeof scope.myImage.urlPath == 'undefined' 
        scope.myImage={urlPath:'//:0'}
      else if scope.myImage.urlPath == null
        scope.myImage={urlPath:'//:0'}
      return false  

    placehold=()->
      scope.placehold=true
      empty1x1png = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mMw+g8AAWYBMpSqGxwAAAAASUVORK5CYII="
      src = "data:image/png;base64," + empty1x1png
      element.css 
        'background-image':'url('+src+')'
        'background-repeat':'repeat'
      if element.hasClass('img-circle')
        element.css
          'padding-bottom':'100%'
      scope.myImage={urlPath:'//:0'} 
    if typeof scope.myImage =='undefined'
      placehold()
    else if typeof scope.myImage.urlPath == 'undefined'
      placehold()
    else if scope.myImage.urlPath == null || scope.myImage.urlPath == '//:0'
      placehold()
    else  
      scope.placehold=false


    element.on 'click', (e)->
      # console.log 'click',e
      # e.target.getAttribute('my-image')
      if e.target.tagName != 'DIV' & e.target.tagName != 'IMG'
        return null
      modalInstance=$modal.open
        size:'lg'
        templateUrl:'components/mysite/myImage/myImageModal.html'
      modalInstance.result.then (image)->

        if typeof image != 'undefined'
          console.log 'defined'
          scope.myImage=image
          scope.placehold=false
          element.css
            'background-image':''
            'background-repeat':''
            'padding-bottom':''
        else
          placehold()
          # behavior of ng-src demans that a non-null value be passed. This is best way


    
    

    