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
    'angucomplete-alt',
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/intro.html'
        controller: 'MainCtrl'
      .when '/search',
        templateUrl: 'views/search.html',
        controller: 'SearchCtrl'
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
      beers_visited: {}
      breweries_visited: {}

    $http.get('data/countries.json').success (data) ->
      $rootScope.countries = angular.fromJson data
      country.visited = 0 for country in $rootScope.countries

    $http.get('data/type.json').success (data) ->
      $rootScope.types = angular.fromJson data
      type.visited = 0 for type in $rootScope.types

    $http.get('data/strength.json').success (data) ->
      $rootScope.strengths = angular.fromJson data
      strength.visited = 0 for strength in $rootScope.strengths

    $http.get('data/beers.json').success (data) ->
      $rootScope.beers = angular.fromJson data
      beer.visited = 0 for beer in $rootScope.beers

    $http.get('data/breweries.json').success (data) ->
      $rootScope.breweries = angular.fromJson data
      brewery.visited = 0 for brewery in $rootScope.breweries

  .filter "newline", () ->
    (data) ->
      return data.replace(/\n\r?/g, '<br />')