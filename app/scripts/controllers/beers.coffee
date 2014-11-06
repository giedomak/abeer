'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
.controller 'BeersCtrl', ($rootScope, $routeParams, $scope, $http, $location) ->
	$rootScope.curTab = 'beers'
	console.log "BeersCtrl init"
	$rootScope.UM.visited_beers++
	$scope.page = $routeParams.page or Math.floor((Math.random() * 300) + 1)
	console.log $scope.page
	$scope.defaultImg = "images/defaultMedium.jpeg"
	$scope.beerResults = []
	$scope.beerResultsNames = []

	$scope.getIndexIfObjWithOwnAttr = (value) ->
		if $rootScope.breweries.length >= 0
			i = 0
			while i < $rootScope.breweries.length
				return i  if $rootScope.breweries[i]['breweryID'] is value
				i++
			1

	$http.get('http://abeerfor.me/api/beers?withBreweries=Y&p='.concat($scope.page))
	.success (data) ->
		$scope.beers = (beer for beer in data.data)
		console.log $scope.beers

	$scope.selectedBeer = (data) ->
		$location.path("/beer/" + data.description.id)

	$scope.searchForBeer = (query) ->
		$http.get('http://abeerfor.me/api/search?q='.concat(query).concat('&type=beer'))
		.success (data) ->
			$scope.beerResults = (beer for beer in data.data)
			$scope.beerResultsNames = (beer.name for beer in data.data)


	$scope.getBeerWithName = (value) ->
		i = 0
		while i < $scope.beerResults.length
			return i  if $scope.beerResults[i]['name'] is value
			i++
		return i



	$scope.loadBeerPage = (beer) ->
		$location.path("/beer/" + $scope.beerResults[$scope.getBeerWithName(beer)]['id'])

	$scope.addPics = (results) ->
		for beer in results.data
			if not beer.labels
				beer.labels = {}
				beer.labels.icon = ""
		return results

	$scope.goBack = () ->
		$location.path("beers/" + (parseInt($scope.page) - 1))

	$scope.goNext = () ->
		$location.path("beers/" + (parseInt($scope.page) + 1))
