'use strict'

angular.module('abeerApp')
  .controller 'BeerCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Beers init"
    $scope.id = $routeParams.id
    $rootScope.beers[$scope.id].visited++