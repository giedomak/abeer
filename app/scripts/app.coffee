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
      .when '/countries',
        templateUrl: 'views/include.html',
        controller: 'IncludeCtrl'
      .when '/countries/:id',
        templateUrl: 'views/include.html',
        controller: 'IncludeCtrl'
      .when '/types',
        templateUrl: 'views/include.html',
        controller: 'IncludeCtrl'
      .when '/types/:id',
        templateUrl: 'views/include.html',
        controller: 'IncludeCtrl'
    .when '/strengths',
      templateUrl: 'views/include.html',
      controller: 'IncludeCtrl'
    .when '/strengths/:id',
      templateUrl: 'views/include.html',
      controller: 'IncludeCtrl'
#      .otherwise
#        redirectTo: '/'
  .run ($rootScope, $http, $location) ->
    $rootScope.UM =
      name: "Giedo"
      oldEnough:false
      setAge:false
      visited_home: 0
      visited_about: 0
      visited_beers: 0
      visited_breweries: 0
      beers_local: {}
      breweries_local: {}
      countries: {}
      strengths: {}
      types: {}

    $rootScope.isAgeGateway = () ->
      if $location.path() == "/AgeGateway"
        return true
      return false

    $rootScope.BV = new $.BigVideo()


  .filter "newline", () ->
    (data) ->
      return data.replace(/\n\r?/g, '<br />')

