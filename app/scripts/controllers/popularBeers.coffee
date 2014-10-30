'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
.controller 'PopularBeersCtrl', ($routeParams, $rootScope, $scope, $http) ->
  $rootScope.curTab = 'popularBeers'
  $scope.defaultImg = "images/defaultMedium.jpeg"

  $scope.basicBeerSearch = () ->
    $http.get('http://abeerfor.me/popular')
    .success (data) ->
      console.log data
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

  $scope.ratingClick = (beer,rating) ->
    if !$rootScope.UM.beers_local[beer.id]
      $rootScope.initializeBeer(beer)
    $rootScope.UM.beers_local[beer.id].rating = rating

  $scope.drinkLaterClick = (beer) ->
    if !$rootScope.UM.beers_local[beer.id]
      $rootScope.initializeBeer(beer)
    $rootScope.UM.beers_local[beer.id].drinkLater = beer.drinkLater



  $scope.goBack = () ->
    $location.path("ratebeers/"+ (parseInt($scope.page) - 1))

  $scope.goNext = () ->
    $location.path("ratebeers/"+ (parseInt($scope.page) + 1))

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

