'use strict'

angular.module 'mydrive5App'
.directive 'statisticBox', ($filter)->
  templateUrl: 'components/statistic-box/statistic-box.html'
  restrict: 'EA'
  scope: 
    totalDonated:'@'
    goal:'@'
  link: (scope, element, attrs) ->
    scope.$watch 'totalDonated', ->
      scope.percentGoal=$filter('number')(scope.totalDonated/scope.goal*100,0)
      false
