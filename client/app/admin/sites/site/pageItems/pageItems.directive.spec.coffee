'use strict'

describe 'Directive: pageItems', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'app/admin/sites/site/pageItems/pageItems.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<page-items></page-items>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the pageItems directive'

