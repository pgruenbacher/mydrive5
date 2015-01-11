'use strict'

describe 'Directive: myRow', ->

  # load the directive's module
  beforeEach module 'mydrive5App'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<my-row></my-row>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the myRow directive'
