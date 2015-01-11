'use strict'

angular.module 'mydrive5App'
.directive 'myImage', ($modal,config)->
  restrict: 'A'
  transclude:true
  scope:
    myImage:'='
    background:'@'
  template:'<div ng-show="placehold" class="holder-text">Click to edit image (this placeholder won\'t appear on the website otherwise)</div><div ng-transclude></div>'
  link: (scope, element, attrs) ->
    if scope.background
      if typeof scope.myImage != 'undefined'
        if typeof scope.myImage.urlPath != 'undefined'
            if scope.myImage.urlPath != '//:0'
              element.css
                'background-image':'url('+scope.myImage.urlPath+')'
            else
              element.css
                'background-color':'#333333'
        else
          element.css
            'background-color':'#333333'
      else
        element.css
          'background-color':'#333333'
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
      grid10x10png = "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAYAAACNMs+9AAAAIklEQVQYV2M0Njb+z4AGBAUF0YUYGIeCQiUlJeI8MwQUAgD+ORD6b8E58gAAAABJRU5ErkJggg=="
      src = "data:image/png;base64," + grid10x10png
      element.css 
        'background-image':'url('+src+')'
        'background-repeat':'repeat'
        'background-size':'auto'
        'background-position':'inherit'
      if element.hasClass('img-circle')
        element.css
          'padding-bottom':'100%'
      # else
      #   element.css
      #     'padding-bottom':'50%'
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
          scope.myImage=image
          scope.placehold=false
          element.css
            'background-position':''
            'background-size':''
            'background-image':''
            'background-repeat':''
            'padding-bottom':''
          if scope.background
            element.css
              'background-image':'url('+scope.myImage.urlPath+')'
        else
          placehold()
          # behavior of ng-src demans that a non-null value be passed. This is best way


    
    

    