'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
.controller 'BeertinderCtrl', ($routeParams, $rootScope, $scope, $http, $location, $timeout) ->
  $rootScope.curTab = 'rateBeers'
  $scope.page = $routeParams.page
  $scope.defaultImg = "images/defaultMedium.jpeg"

  $http.get('http://abeerfor.me:1991/popular').success (data) ->
    console.log data
    $scope.beers = data
    for value, index in $scope.beers
      value.rating = null
      value.drinkLater = null
      if $rootScope.UM.beers_local[value.id]
        console.log("Found beer in UM")
        console.log($rootScope.UM.beers_local[value.id])
        value.rating = $rootScope.UM.beers_local[value.id].rating
        value.drinkLater = $rootScope.UM.beers_local[value.id].drinkLater
    $scope.i = 0
    $scope.currBeer = $scope.beers[$scope.i]

  $scope.ratingClick = (beer, rating) ->
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


  $scope.likeBtn = () ->
    if !$rootScope.UM.beers_local[$scope.currBeer.id]
      $rootScope.initializeBeer($scope.currBeer)
    $rootScope.UM.beers_local[$scope.currBeer.id].rating = 5
    $http.get('http://www.abeerfor.me:1991/ratebeer/'.concat($scope.currBeer.id).concat("/").concat(5))
    $('.photo').addClass('match')
    console.log "Like " + $scope.currBeer.name
    $timeout( () ->
      $scope.i++
      $scope.currBeer = $scope.beers[$scope.i]
      $('.photo').removeClass('match')
    ,1000 )
    return true
  $scope.dislikeBtn = () ->
    if !$rootScope.UM.beers_local[$scope.currBeer.id]
      $rootScope.initializeBeer($scope.currBeer)
    $rootScope.UM.beers_local[$scope.currBeer.id].rating = 1
    $http.get('http://www.abeerfor.me:1991/ratebeer/'.concat($scope.currBeer.id).concat("/").concat(1))
    $('.photo').addClass('dislike')
    console.log "Dislike " + $scope.currBeer.name
    $timeout( () ->
      $scope.i++
      $scope.currBeer = $scope.beers[$scope.i]
      $('.photo').removeClass('dislike')
    ,1000 )
    return true


