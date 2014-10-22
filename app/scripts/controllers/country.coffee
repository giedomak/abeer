'use strict'

angular.module('abeerApp')
  .controller 'CountryCtrl', ($sce, $http, $routeParams, $rootScope, $scope) ->
    console.log "Country init"
    id = $routeParams.id

    if id of $rootScope.UM.countries
      $rootScope.UM.countries[id].visited++
    else
      $rootScope.UM.countries[id] = {}
      $rootScope.UM.countries[id].visited = 1

    $scope.visited = $rootScope.UM.countries[id].visited

    $scope.url = "views/countries/"+id+".html"

