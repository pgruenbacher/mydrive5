'use strict'

describe 'Directive: statisticBox', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/statistic-box/statistic-box.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<statistic-box></statistic-box>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the statisticBox directive'

