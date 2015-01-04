'use strict'

describe 'Controller: PageCtrl', ->

  # load the controller's module
  beforeEach module 'mydrive5App'
  PageCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    PageCtrl = $controller 'PageCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
