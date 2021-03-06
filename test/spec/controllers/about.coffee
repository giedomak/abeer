'use strict'

describe 'Controller: AboutCtrl', ->

  # load the controller's module
  beforeEach module 'abeerApp'

  AboutCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AboutCtrl = $controller 'AboutCtrl', {
      $scope: scope
    }

  it 'should attach about to the curTab', ->
    expect(scope.curTab).toBe 'about'
