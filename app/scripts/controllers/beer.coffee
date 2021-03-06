'use strict'

angular.module('abeerApp')
  .controller 'BeerCtrl', ($routeParams, $rootScope, $scope, $http) ->
    console.log "Beers init"
    $scope.id = $routeParams.id
    $http.get('http://www.abeerfor.me/api/beer/'.concat($scope.id).concat('?withBreweries=Y'))
      .success (data) ->
        $scope.beerData = data.data
        $scope.beerData.rating = null
        if !$rootScope.UM.beers_local[$scope.id]
          $rootScope.initializeBeer($scope.beerData)
        $rootScope.UM.beers_local[$scope.id].visited++
        $scope.beerData.rating = $rootScope.UM.beers_local[$scope.id].rating
        $scope.beerData.drinkLater = $rootScope.UM.beers_local[$scope.id].drinkLater
        $scope.beerData.description = $rootScope.linkAnnotate($scope.beerData.description) if $scope.beerData.description
        $scope.beerData.style.description = $rootScope.linkAnnotate($scope.beerData.style.description) if $scope.beerData.style


    $scope.defaultImg = "images/default.jpg"


    $scope.ratingClick = (beer,rating) ->
      if !$rootScope.UM.beers_local[$scope.id]
       $rootScope.initializeBeer(beer)
      $rootScope.UM.beers_local[$scope.id].rating = rating
      beer.rating = rating
      $http.get('http://www.abeerfor.me:1991/ratebeer/'.concat(beer.id).concat("/").concat(rating))

    $scope.drinkLaterClick = (beer) ->
      if !$rootScope.UM.beers_local[$scope.id]
        $rootScope.initializeBeer(beer)
      $rootScope.UM.beers_local[$scope.id].drinkLater = $scope.beerData.drinkLater


