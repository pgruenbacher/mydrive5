'use strict'

angular.module 'mydrive5App'
.directive 'headroom', ()->
  restrict: 'EA'
  scope:
    tolerance:'='
    offset:'='
    classes:'='
    scroller:'@'
  link: (scope, element, attrs) ->
    options={}
    angular.forEach Headroom.options, (value,key)->
      options[key]=scope[key] || Headroom.options[key]

    if options.scroller
      options.scroller = angular.element(options.scroller)[0]

    headroom = new Headroom(element[0], options)
    headroom.init()
    scope.$on 'destroy', ->
      headroom.destroy()
