'use strict'

describe 'Controller: MediaCtrl', ->

  # load the controller's module
  beforeEach module 'mydrive5App'
  MediaCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MediaCtrl = $controller 'MediaCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
