'use strict'

angular.module('abeerApp')
  .controller 'CountryCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Country init"
    $scope.country_id = $routeParams.country
    $rootScope.countries[$scope.country_id].visited++
