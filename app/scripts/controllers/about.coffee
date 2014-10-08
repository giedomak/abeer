'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
  .controller 'AboutCtrl', ($rootScope, $scope) ->
    $rootScope.curTab = 'about'
    $rootScope.UM.visited_about++

    $scope.beers =
      description: "hello"
