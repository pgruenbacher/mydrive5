'use strict'

describe 'Directive: adminNavbar', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/adminNavbar/adminNavbar.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<admin-navbar></admin-navbar>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the adminNavbar directive'

