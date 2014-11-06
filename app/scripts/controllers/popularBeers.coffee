'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
	.controller 'PopularBeersCtrl', ($scope, $rootScope, $http) ->
		$rootScope.curTab = 'popularBeers'
		$scope.defaultImg = "images/defaultMedium.jpeg"
		$scope.beers = []

		$http.get('http://abeerfor.me:1991/popular').success (data) ->
			$scope.beers = data
			for beer in $scope.beers
				beer.drinkLater = null
				if $rootScope.UM.beers_local[beer.id]
					beer.rating = $rootScope.UM.beers_local[beer.id].rating
					beer.drinkLater = $rootScope.UM.beers_local[beer.id].drinkLater
			$scope.beers.sort($scope.compare)
			console.log data
			$scope.makeBeerRows($scope.beers, 3)


		$scope.compare = (beerA, beerB) ->
			return beerB['sum_ratings'] - beerA['sum_ratings']


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

