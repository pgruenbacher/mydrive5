'use strict'

describe 'Directive: palettePicker', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/palettePicker/palettePicker.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<palette-picker></palette-picker>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the palettePicker directive'

