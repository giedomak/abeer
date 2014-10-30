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
          $rootScope.initializeBeer($scope.beerData)
        $rootScope.UM.beers_local[$scope.id].visited++
        $scope.beerData.rating = $rootScope.UM.beers_local[$scope.id].rating
        $scope.beerData.drinkLater = $rootScope.UM.beers_local[$scope.id].drinkLater
        $scope.beerData.description = $rootScope.linkAnnotate($scope.beerData.description)
        $scope.beerData.style.description = $rootScope.linkAnnotate($scope.beerData.style.description)


    $scope.defaultImg = "images/default.jpg"


    $scope.ratingClick = (beer,rating) ->
      if !$rootScope.UM.beers_local[$scope.id]
       $rootScope.initializeBeer(beer)
      $rootScope.UM.beers_local[$scope.id].rating = rating
      beer.rating = rating

    $scope.drinkLaterClick = (beer) ->
      if !$rootScope.UM.beers_local[$scope.id]
        $rootScope.initializeBeer(beer)
      $rootScope.UM.beers_local[$scope.id].drinkLater = $scope.beerData.drinkLater


