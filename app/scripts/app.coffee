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
    'ngTouch'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/intro.html'
#        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl'
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
      .when '/country/:id',
        templateUrl: 'views/country.html',
        controller: 'CountryCtrl'
      .when '/types/:id',
        templateUrl: 'views/type.html',
        controller: 'TypeCtrl'
    .when '/strengths/:id',
      templateUrl: 'views/strength.html',
      controller: 'StrengthCtrl'
#      .otherwise
#        redirectTo: '/'
  .run ($rootScope, $http) ->
    $rootScope.UM =
      name: "Giedo"
      visited_home: 0
      visited_about: 0
      visited_beers: 0
      visited_breweries: 0

    $http.get('data/countries.json').success (data) ->
      $rootScope.countries = angular.fromJson data
      country.visited = 0 for country in $rootScope.countries
      console.log $rootScope.countries

    $http.get('data/type.json').success (data) ->
      $rootScope.types = angular.fromJson data
      type.visited = 0 for type in $rootScope.types
      console.log $rootScope.types

    $http.get('data/strength.json').success (data) ->
      $rootScope.strengths = angular.fromJson data
      strength.visited = 0 for strength in $rootScope.strengths
      console.log $rootScope.strengths

    $http.get('data/beers.json').success (data) ->
      $rootScope.beers = angular.fromJson data
      beer.visited = 0 for beer in $rootScope.beers
      console.log $rootScope.beers

    $http.get('data/breweries.json').success (data) ->
      $rootScope.breweries = angular.fromJson data
      brewery.visited = 0 for brewery in $rootScope.breweries
      console.log $rootScope.breweries

  .filter "newline", () ->
    (data) ->
      return data.replace(/\n\r?/g, '<br />')