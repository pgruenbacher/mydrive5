'use strict'

angular.module 'mydrive5App'
.directive 'subscriptionForm', ($http)->
  templateUrl: 'components/mysite/subscriptionForm/subscriptionForm.html'
  restrict: 'EA'
  link: (scope, element, attrs) ->
    scope.submit=(email)->
      console.log 'submit'
      $http.post 'api/data/subscribers', {email:email}
