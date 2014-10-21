'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
.controller 'RateBeersCtrl', ($routeParams, $rootScope, $scope, $http, $location) ->
  $rootScope.curTab = 'rateBeers'
  $scope.page = $routeParams.page
  $scope.defaultImg = "images/defaultMedium.jpeg"

  console.log($rootScope.UM.beers_local)

  $scope.basicBeerSearch = () ->
  $http.get('http://abeerfor.me/api/beers?hasLabels=Y&p='.concat($scope.page))
  .success (data) ->
    $scope.beers = (beer for beer in data.data)
    for value, index in $scope.beers
      value.rating = null
      if $rootScope.UM.beers_local[value.id]
        console.log("Found beer in UM")
        console.log($rootScope.UM.beers_local[value.id])
        value.rating = $rootScope.UM.beers_local[value.id].rating

  $scope.ratingClick = (beer,rating) ->
    if $rootScope.UM.beers_local[beer.id]
      $rootScope.UM.beers_local[beer.id].rating = rating
    else
      $rootScope.UM.beers_local[beer.id] = beer
      $rootScope.UM.beers_local[beer.id].rating = rating

  $scope.goBack = () ->
    $location.path("ratebeers/"+ (parseInt($scope.page) - 1))

  $scope.goNext = () ->
    $location.path("ratebeers/"+ (parseInt($scope.page) + 1))

