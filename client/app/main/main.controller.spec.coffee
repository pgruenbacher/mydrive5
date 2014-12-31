'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'mydrive5App' 
  beforeEach module 'stateMock' 
  beforeEach module 'socketMock' 

  MainCtrl = undefined
  scope = undefined
  state = undefined
  $httpBackend = undefined

  # Initialize the controller and a mock scope
  beforeEach inject (_$httpBackend_, $controller, $rootScope, $state) ->
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET('/api/things').respond [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
      'Express'
    ]
    scope = $rootScope.$new()
    state = $state
    MainCtrl = $controller 'MainCtrl',
      $scope: scope

  it 'should attach a list of things to the scope', ->
    $httpBackend.flush()
    expect(scope.awesomeThings.length).to.equal 4
