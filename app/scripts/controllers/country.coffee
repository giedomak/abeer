'use strict'

angular.module('abeerApp')
  .controller 'CountryCtrl', ($sce, $http, $routeParams, $rootScope, $scope) ->
    console.log "Country init"
    id = $routeParams.id

    if id in $rootScope.countries
      $rootScope.countries.id.visited++
    else
      $rootScope.countries.id = {}
      $rootScope.countries.id.visited = 1

    $scope.visited = $rootScope.countries.id.visited

    $scope.url = "views/countries/"+id+".html"

