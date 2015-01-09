'use strict'

angular.module 'mydrive5App'
.directive 'subscriptionForm', ->
  templateUrl: 'components/mysite/subscriptionForm/subscriptionForm.html'
  restrict: 'EA'
  link: (scope, element, attrs) ->
