'use strict'

describe 'Controller: DataCtrl', ->

  # load the controller's module
  beforeEach module 'mydrive5App'
  DataCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DataCtrl = $controller 'DataCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
