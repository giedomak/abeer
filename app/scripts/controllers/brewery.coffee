'use strict'

angular.module('abeerApp')
  .controller 'BreweryCtrl', ($routeParams, $rootScope, $scope, $http) ->
    console.log "Brewery init"
    $scope.defaultImg = "images/defaultBreweryMedium.jpeg"
    $scope.defaultImgBeer = "images/default.jpg"

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



    $scope.breweryRatingClick = (brewery,rating) ->
      if $rootScope.UM.breweries_local[$scope.id]
        $rootScope.UM.breweries_local[$scope.id].rating = rating
      else
        $rootScope.UM.breweries_local[$scope.id] = brewery
        $rootScope.UM.breweries_local[$scope.id].rating = rating
      brewery.rating = rating


    $http.get('http://www.abeerfor.me/api/brewery/'.concat($scope.id).concat('/beers'))
      .success (data) ->
        $scope.beers = (beer for beer in data.data)
        for value, index in $scope.beers
          value.rating = null
          value.drinkLater = null
          if $rootScope.UM.beers_local[value.id]
            console.log("Found beer in UM")
            console.log($rootScope.UM.beers_local[value.id])
            value.rating = $rootScope.UM.beers_local[value.id].rating
            value.drinkLater = $rootScope.UM.beers_local[value.id].drinkLater
        $scope.makeBeerRows($scope.beers, 3)


    $scope.beerRatingClick = (beer,rating) ->
      if !$rootScope.UM.beers_local[beer.id]
        $rootScope.initializeBeer(beer)
      $rootScope.UM.beers_local[beer.id].rating = rating
      $http.get('http://www.abeerfor.me:1991/ratebeer/'.concat(beer.id).concat("/").concat(rating))

    $scope.drinkLaterClick = (beer) ->
      if !$rootScope.UM.beers_local[beer.id]
        $rootScope.initializeBeer(beer)
      $rootScope.UM.beers_local[beer.id].drinkLater = true
      $rootScope.UM.beers_local[beer.id].drinkLater = beer.drinkLater


    $scope.goBack = () ->
      $location.path("ratebeers/" + (parseInt($scope.page) - 1))

    $scope.goNext = () ->
      $location.path("ratebeers/" + (parseInt($scope.page) + 1))

    $scope.makeBeerRows = (arr, lengthofsublist) ->
      if not angular.isUndefined(arr) and arr.length > 0
        $scope.beerRows= []
        subArray = []
        pushed = true
        i = 0

        while i < arr.length
          if (i + 1) % lengthofsublist is 0
            subArray.push i
            $scope.beerRows.push subArray
            subArray = []
            pushed = true
          else
            subArray.push i
            pushed = false
          i++
        $scope.beerRows.push subArray  unless pushed

