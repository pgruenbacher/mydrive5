'use strict'

angular.module 'mydrive5App'
.directive 'myFaq', (config)->
  templateUrl:'components/mysite/myFaq/myFaq.html'
  restrict: 'EA'
  scope: 
    faqs:'='
    editorOptions:'@'
  link: (scope, element, attrs) ->
    scope.editable = !config.public()
    scope.newFaq=->
      scope.faqs.push
        title:'New Faq'
        content:'<p>New content</p>'

    scope.deleteFaq=(index)->
      scope.faqs.splice(index,1)
