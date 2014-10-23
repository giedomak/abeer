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

