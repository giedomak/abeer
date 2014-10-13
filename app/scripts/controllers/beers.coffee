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
    $scope.defaultImg = "images/defaultMedium.jpeg"
    $scope.getIndexIfObjWithOwnAttr = (value) ->
      i = 0
      while i < $rootScope.breweries.length
        return i  if $rootScope.breweries[i]['breweryID'] is value
        i++
      1
