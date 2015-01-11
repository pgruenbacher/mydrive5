'use strict'

describe 'Directive: myTab', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/mysite/myTab/myTab.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<my-tab></my-tab>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the myTab directive'

