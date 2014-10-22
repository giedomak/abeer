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
    'ui.bootstrap'
  ])
  .config ($routeProvider) ->
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
      .when '/about',
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl'
      .when '/beers/:id',
        templateUrl: '/views/beer.html',
        controller: 'BeerCtrl'
      .when '/beers',
        templateUrl: 'views/beers.html',
        controller: 'BeersCtrl'
      .when '/breweries',
        templateUrl: 'views/breweries.html',
        controller: 'BreweriesCtrl'
      .when '/beers/:id',
        templateUrl: 'views/beer.html',
        controller: 'BeerCtrl'
      .when '/breweries/:id',
        templateUrl: 'views/brewery.html',
        controller: 'BreweryCtrl'
      .when '/countries/:id',
        templateUrl: 'views/include.html',
        controller: 'CountryCtrl'
      .when '/types/:id',
        templateUrl: 'views/include.html',
        controller: 'TypeCtrl'
    .when '/strengths/:id',
      templateUrl: 'views/include.html',
      controller: 'StrengthCtrl'
#      .otherwise
#        redirectTo: '/'
  .run ($rootScope, $http, $location) ->
    $rootScope.UM =
      name: "Giedo"
      age:0
      visited_home: 0
      visited_about: 0
      visited_beers: 0
      visited_breweries: 0
      beers_local: {}
      breweries_local: {}
      countries: {}
      strengths: {}
      types: {}

    $http.get('data/countries.json').success (data) ->
      $rootScope.countries = angular.fromJson data
      country.visited = 0 for country in $rootScope.countries

    $http.get('data/type.json').success (data) ->
      $rootScope.types = angular.fromJson data
      type.visited = 0 for type in $rootScope.types

    $http.get('data/strength.json').success (data) ->
      $rootScope.strengths = angular.fromJson data
      strength.visited = 0 for strength in $rootScope.strengths
    $rootScope.isAgeGateway = () ->
      if $location.path() == "/AgeGateway"
        return true
      return false

  .filter "newline", () ->
    (data) ->
      return data.replace(/\n\r?/g, '<br />')