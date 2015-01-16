'use strict'

describe 'Controller: SiteSettingsCtrl', ->

  # load the controller's module
  beforeEach module 'mydrive5App'
  SiteSettingsCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    SiteSettingsCtrl = $controller 'SiteSettingsCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
