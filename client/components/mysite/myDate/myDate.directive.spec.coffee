'use strict'

describe 'Directive: myDate', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/mysite/myDate/myDate.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<my-date></my-date>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the myDate directive'

