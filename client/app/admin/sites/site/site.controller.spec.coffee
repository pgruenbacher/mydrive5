'use strict'

describe 'Controller: SiteCtrl', ->

  # load the controller's module
  beforeEach module 'mydrive5App'
  SiteCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    SiteCtrl = $controller 'SiteCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
