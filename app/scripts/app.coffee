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
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl',
      .when '/country/:id',
        templateUrl: 'views/country.html',
        controller: 'CountryCtrl'
      .otherwise
        redirectTo: '/'
  .run ($rootScope, $http) ->
    $rootScope.UM =
      name: "Giedo"
      visited_home: 0
      visited_about: 0

    $http.get('data/countries.json').success (data) ->
      $rootScope.countries = angular.fromJson data
      country.visited = 0 for country in $rootScope.countries
      console.log $rootScope.countries
