'use strict'

angular.module 'mydrive5App'
.factory 'Breadcrumb', ($state,$interpolate,$stateParams,$window)->
  get:->
    title='welcome'
    state=$state.current
    if typeof state.data != 'undefined'
      if typeof state.data.title != 'undefined'
        title=$interpolate(state.data.title)($state.$current.locals.globals)
        $window.document.title=title
    return title


.directive "dynamicTitle", (Breadcrumb,$rootScope)->
  restrict: "EA"
  link: (scope, element, attributes)->
    listener=->
      element.text(Breadcrumb.get())
    listener()
    $rootScope.$on('$stateChangeSuccess', listener);