'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
.controller 'BeerTinderCtrl', ($routeParams, $rootScope, $scope, $http, $location) ->
  $rootScope.curTab = 'rateBeers'
  $scope.page = $routeParams.page
  $scope.defaultImg = "images/defaultMedium.jpeg"

  $http.get('http://abeerfor.me/api/beers?hasLabels=Y&p='.concat($scope.page))
    .success (data) ->
      $scope.beers = (beer for beer in data.data)
      for value, index in $scope.beers
        value.rating = null
        value.drinkLater = null
        value.labels.large = value.labels.large || $scope.defaultImg
        if $rootScope.UM.beers_local[value.id]
          console.log("Found beer in UM")
          console.log($rootScope.UM.beers_local[value.id])
          value.rating = $rootScope.UM.beers_local[value.id].rating
          value.drinkLater = $rootScope.UM.beers_local[value.id].drinkLater
      $scope.makeBeerRows($scope.beers, 3)


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

  $scope.makeBeerRows = (arr, lengthofsublist) ->
    if not angular.isUndefined(arr) and arr.length > 0
      $scope.beerRows = []
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

  $scope.direction = "left"
  $scope.currentIndex = 0
  $scope.setCurrentSlideIndex = (index) ->
    $scope.direction = (if (index > $scope.currentIndex) then "left" else "right")
    $scope.currentIndex = index


  $scope.isCurrentSlideIndex = (index) ->
    $scope.currentIndex is index


  $scope.prevSlide = ->
    $scope.direction = "left"
    $scope.currentIndex = (if ($scope.currentIndex < $scope.beers.length - 1) then ++$scope.currentIndex else 0)

  $scope.nextSlide = ->
    $scope.direction = "right"
    $scope.currentIndex = (if ($scope.currentIndex > 0) then --$scope.currentIndex else $scope.beers.length - 1)

.animation ".slide-animation", () ->
  addClass: (element, className, done) ->
    scope = element.scope()
    if className is "ng-hide"
      finishPoint = element.parent().width()
      finishPoint = -finishPoint  if scope.direction isnt "right"
      TweenMax.to element, 0.5,
        left: finishPoint
        onComplete: done

    else
      done()
    return

  removeClass: (element, className, done) ->
    scope = element.scope()
    if className is "ng-hide"
      element.removeClass "ng-hide"
      startPoint = element.parent().width()
      startPoint = -startPoint  if scope.direction is "right"
      TweenMax.set element,
        left: startPoint

      TweenMax.to element, 0.5,
        left: 0
        onComplete: done

    else
      done()
    return
