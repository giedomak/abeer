'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'abeerApp'

  MainCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }

  it 'should attach home to the curTab', ->
    expect(scope.curTab).toBe 'home'
