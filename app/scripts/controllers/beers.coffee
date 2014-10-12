'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
  .controller 'BeersCtrl', ($rootScope, $scope) ->
    $rootScope.curTab = 'beers'
    $rootScope.UM.visited_beers++
