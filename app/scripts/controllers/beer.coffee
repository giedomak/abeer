'use strict'

angular.module('abeerApp')
  .controller 'BeerCtrl', ($routeParams, $rootScope, $scope, $http) ->
    console.log "Beers init"
    $scope.id = $routeParams.id
    $http.get('http://www.abeerfor.me/api/beer/'.concat($scope.id))
      .success (data) ->
        $scope.beerData = data.data
        $scope.beerData.rating = null
        if !$rootScope.UM.beers_local[$scope.id]
          $rootScope.UM.beers_local[$scope.id] = $scope.beerData
          $rootScope.UM.beers_local[$scope.id].visited = 1
        else
          $rootScope.UM.beers_local[$scope.id].visited++
          $scope.beerData.rating = $rootScope.UM.beers_local[$scope.id].rating

    $scope.defaultImg = "images/default.jpg"


    $scope.ratingClick = (beer,rating) ->
      if $rootScope.UM.beers_local[$scope.id]
        $rootScope.UM.beers_local[$scope.id].rating = rating
      else
        $rootScope.UM.beers_local[$scope.id] = beer
        $rootScope.UM.beers_local[$scope.id].rating = rating
      beer.rating = rating
