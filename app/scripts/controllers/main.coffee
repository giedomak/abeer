'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
  .controller 'MainCtrl', ($http, $window, $route, $rootScope, $scope, $location) ->
    $rootScope.curTab = 'home'
    $rootScope.UM.visited_home++

    if !$rootScope.UM.setAge
      $location.path("/AgeGateway")
