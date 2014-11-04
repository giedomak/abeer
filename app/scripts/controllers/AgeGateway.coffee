'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
.controller 'AgeGatewayCtrl', ($routeParams, $rootScope, $scope, $location, $http) ->
	$rootScope.BV.init()
	$rootScope.BV.show("videos/beer.mp4",
			{altSource: "videos/beer.webm", ambient:true})



	$scope.day = undefined
	$scope.month = undefined
	$scope.year = undefined

	$scope.calendar = Date()
	$scope.countryCode = null
	$http.get('data/ageCountries.json').success (data) ->
		$scope.ageCountries = angular.fromJson data
		$scope.flatCountries = Object.keys($scope.ageCountries).map((k) ->
			$scope.ageCountries[k])
		for country in $scope.flatCountries
			for each in Object.keys($scope.ageCountries)
				if $scope.ageCountries[each].name == country.name
					country.code = each
		$scope.flatCountries.sort (a,b) ->
			if a.name < b.name then return -1
			if a.name >= b.name then return 1

	$scope.checkAge = () ->
		todayDate = new Date()
		todayYear = todayDate.getFullYear()
		todayMonth = todayDate.getMonth()
		todayDay = todayDate.getDate()
		age = todayYear - $scope.year
		age--  if todayMonth < ($scope.month - 1)
		age--  if ($scope.month is todayMonth) and todayDay < $scope.day
		$rootScope.UM.age = age
		if $scope.oldEnoughForCountry(age)
			$rootScope.UM.oldEnough = true
		$rootScope.BV.remove()
		$rootScope.UM.setAge = true
		$location.path("/")

	$scope.oldEnoughForCountry = (age) ->
		$scope.drinkingAge = $scope.country.drinking
		if $scope.drinkingAge <= $rootScope.UM.age
			console.log("Old enough")
			return true
		console.log("Not enough")
		return false


	$scope.receivedLoc = (position) ->
		latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
		$scope.geocoder.geocode({'latLng':latlng}, (result, status) ->
			for listing in result[0].address_components
				if "country" in listing.types
					$scope.countryCode = listing.short_name
			for country in $scope.flatCountries
				if country.code == $scope.countryCode.toLowerCase()
					$scope.country = country
		)

	$scope.geocoder = new google.maps.Geocoder();
	navigator.geolocation.getCurrentPosition($scope.receivedLoc);


	$scope.days = [1..31]
	$scope.months = [1..12]
	$scope.years = [1900..2014]
