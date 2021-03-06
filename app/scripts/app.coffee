'use strict'

###*
 # @ngdoc overview
 # @name abeerApp
 # @description
 # # abeerApp
 #
 # Main module of the application.
###
angular
.module('abeerApp', [
			'ngAnimate',
			'ngCookies',
			'ngResource',
			'ngRoute',
			'ngSanitize',
			'ngTouch',
			'angucomplete-alt',
			'ui.bootstrap',
			'google-maps'.ns()
	])
.config ($routeProvider) ->
	include =
		templateUrl: 'views/include.html',
		controller: 'IncludeCtrl'
	$routeProvider
	.when '/',
		templateUrl: 'views/intro.html'
		controller: 'MainCtrl'
	.when '/AgeGateway',
		templateUrl: 'views/AgeGateway.html',
		controller: 'AgeGatewayCtrl'
	.when '/search',
		templateUrl: 'views/search.html',
		controller: 'SearchCtrl'
	.when '/ratebeers/:page',
		templateUrl: '../views/rateBeers.html',
		controller: 'RateBeersCtrl'
	.when '/popular',
		templateUrl: '../views/popularBeers.html',
		controller: 'PopularBeersCtrl'
	.when '/about',
		templateUrl: 'views/about.html',
		controller: 'AboutCtrl'
	.when '/beers/:page',
		templateUrl: 'views/beers.html',
		controller: 'BeersCtrl'
	.when '/beers',
			templateUrl: 'views/beers.html',
			controller: 'BeersCtrl'
	.when '/breweries',
		templateUrl: 'views/breweries.html',
		controller: 'BreweriesCtrl'
	.when '/beer/:id',
		templateUrl: 'views/beer.html',
		controller: 'BeerCtrl'
	.when '/breweries/:id',
		templateUrl: 'views/brewery.html',
		controller: 'BreweryCtrl'
	.when '/nearby',
		templateUrl: 'views/nearby.html',
		controller: 'NearbyCtrl'
	.when '/beertinder',
		templateUrl: 'views/beertinder.html',
		controller: 'BeertinderCtrl'
	.when '/recommendation',
		templateUrl: 'views/directives/whyrecommendation.html',

	# countries, types and strengths all use the include template and controller
	.when '/countries', include
	.when '/countries/:id', include
	.when '/types', include
	.when '/types/:id', include
	.when '/strengths', include
	.when '/strengths/:id', include
#      .otherwise
#        redirectTo: '/'
.run ($rootScope, $http, $location) ->
	$rootScope.UM =
		name: "Giedo"
		oldEnough: false
		setAge: false
		visited_home: 0
		visited_about: 0
		visited_beers: 0
		visited_breweries: 0
		beers_local: {}
		breweries_local: {}
		countries: {}
		strengths: {}
		types: {}
		country:{'code':"nl"}

	$rootScope.isAgeGateway = () ->
		if $location.path() == "/AgeGateway"
			return true
		else
			return false

	$rootScope.BV = new $.BigVideo()

	$rootScope.initializeBeer = (newbeer) ->
		$rootScope.UM.beers_local[newbeer.id] = newbeer
		$rootScope.UM.beers_local[newbeer.id].visited = 0
		$rootScope.UM.beers_local[newbeer.id].drinkLater = false
		$rootScope.UM.beers_local[newbeer.id].rating = null

	$rootScope.countriesJSON = []
	$http.get("/data/countries.json")
	.success (data) ->
		$rootScope.countriesJSON = data

	$rootScope.typeJSON = []
	$http.get("/data/type.json")
	.success (data) ->
		$rootScope.typeJSON = data

	$rootScope.linkAnnotate = (text) ->
		if typeof text is 'string'
			markedUp = text
			for country in $rootScope.countriesJSON

				markedUp = markedUp.replace(country.title,
						"<a href=\"/#/countries/" + country.title.toLowerCase().replace(" ","") + "\">" + country.title + "</a>")
				for altName in country.aka
					markedUp = markedUp.replace(altName,
							"<a href=\"/#/countries/" + country.title.toLowerCase().replace(" ","") + "\">" + altName + "</a>")

			for type in $rootScope.typeJSON
				markedUp = markedUp.replace(type.title, "<a href=\"#/types/" + type.title.toLowerCase().replace(" ","") + "\">" + type.title + "</a>")

			return markedUp

.filter "newline", () ->
	(data) ->
		return data.replace(/\n\r?/g, '<br />')

