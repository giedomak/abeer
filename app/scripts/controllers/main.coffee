'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
  .controller 'MainCtrl', ($http, $rootScope, $scope) ->
    $rootScope.curTab = 'home'
    $http.get('data/beers.json').success (data) ->
      temp = angular.fromJson data
      console.log temp
      $scope.beers = temp.data.beers
#      console.log $scope.beers
#      console.log $scope.beers.beers
#    $scope.beers = angular.fromJson('beers.json')
#    console.log $scope.beers
