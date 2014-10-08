'use strict'

angular.module('abeerApp')
  .controller 'CountryCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Country init"
    $scope.id = $routeParams.id
    $rootScope.countries[$scope.id].visited++
