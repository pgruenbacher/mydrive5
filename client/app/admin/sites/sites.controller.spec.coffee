'use strict'

describe 'Controller: SitesCtrl', ->

  # load the controller's module
  beforeEach module 'mydrive5App'
  SitesCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    SitesCtrl = $controller 'SitesCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
