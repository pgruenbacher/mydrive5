'use strict'

describe 'Directive: ckeditor', ->

  # load the directive's module
  beforeEach module 'mydrive5app'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<ckeditor></ckeditor>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the ckeditor directive'