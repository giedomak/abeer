'use strict'

angular.module('abeerApp')
.controller 'BreweryCtrl', ($routeParams, $rootScope, $scope) ->
  console.log "Brewery init"
  $scope.id = $routeParams.id
  $rootScope.breweries[$scope.id].visited++