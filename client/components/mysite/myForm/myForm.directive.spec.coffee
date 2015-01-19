'use strict'

describe 'Directive: myForm', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/mysite/myForm/myForm.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<my-form></my-form>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the myForm directive'

