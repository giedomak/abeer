'use strict'

angular.module('abeerApp')
.controller 'BeersCtrl', ($rootScope, $scope) ->
  $rootScope.curTab = 'beers'
  $rootScope.UM.visited_beers++
