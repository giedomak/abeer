'use strict'

angular.module('abeerApp')
  .controller 'CountryCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Country init"
    $scope.country = $rootScope.countries[$routeParams.country]

    if $rootScope.countries[$routeParams.country].visited >= 0
      $rootScope.countries[$routeParams.country].visited++
    else
      $rootScope.countries[$routeParams.country].visited = 0
