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

#    $http.get('data/beers.json').success (data) ->
#      temp = angular.fromJson data
#      console.log temp
#      $scope.beers = temp.data.beers
#      console.log $scope.beers
#      console.log $scope.beers.beers
#    $scope.beers = angular.fromJson('beers.json')
#    console.log $scope.beers
#    $scope.reloadRoute = () ->
#      $window.location.reload()
#      true
#   true
