'use strict'

angular.module('abeerApp')
.controller 'BreweryCtrl', ($routeParams, $rootScope, $scope, $http) ->
  console.log "Brewery init"
  $scope.defaultImg = "images/defaultBreweryMedium.jpeg"


  $scope.id = $routeParams.id
  $http.get('http://www.abeerfor.me/api/brewery/'.concat($scope.id))
    .success (data) ->
      $scope.brewery = data.data
      $scope.brewery.rating = null
      if !$rootScope.UM.breweries_local[$scope.id]
        $rootScope.UM.breweries_local[$scope.id] = $scope.brewery
        $rootScope.UM.breweries_local[$scope.id].visited = 1
      else
        $rootScope.UM.breweries_local[$scope.id].visited++
        $scope.brewery.rating = $rootScope.UM.breweries_local[$scope.id].rating


  $scope.ratingClick = (brewery,rating) ->
    if $rootScope.UM.breweries_local[$scope.id]
      $rootScope.UM.breweries_local[$scope.id].rating = rating
    else
      $rootScope.UM.breweries_local[$scope.id] = brewery
      $rootScope.UM.breweries_local[$scope.id].rating = rating
    brewery.rating = rating
