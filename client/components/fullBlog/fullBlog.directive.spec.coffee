'use strict'

describe 'Directive: fullBlog', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/fullBlog/fullBlog.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<full-blog></full-blog>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the fullBlog directive'

