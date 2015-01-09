'use strict'

describe 'Directive: subscriptionForm', ->

  # load the directive's module and view
  beforeEach module 'mydrive5App'
  beforeEach module 'components/mysite/subscriptionForm/subscriptionForm.html'
  element = undefined
  scope = undefined
  beforeEach inject ($rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<subscription-form></subscription-form>'
    element = $compile(element) scope
    scope.$apply()
    expect(element.text()).toBe 'this is the subscriptionForm directive'

