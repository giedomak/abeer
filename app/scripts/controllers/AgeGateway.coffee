'use strict'

###*
 # @ngdoc function
 # @name abeerApp.controller:BeersCtrl
 # @description
 # # BeersCtrl
 # Controller of the abeerApp
###
angular.module('abeerApp')
  .controller 'AgeGatewayCtrl', ($routeParams, $rootScope, $scope, $window, $http) ->

    $scope.day = 1
    $scope.month = 1
    $scope.year = 2014

    $scope.calendar = Date()
    $scope.countryCode = null
    $http.get('data/ageCountries.json').success (data) ->
      $scope.ageCountries = angular.fromJson data
      $scope.flatCountries = Object.keys($scope.ageCountries).map( (k) ->
        $scope.ageCountries[k])
      for country in $scope.flatCountries
        for each in Object.keys($scope.ageCountries)
            if $scope.ageCountries[each].name == country.name
              country.code = each

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
        $window.location.href = "/"

    $scope.oldEnoughForCountry = (age) ->
      $scope.drinkingAge = $scope.country.drinking
      if $scope.drinkingAge <= $rootScope.UM.age
        console.log("Old enough")
        return true
      console.log("Not enough")
      return false

    $scope.countryClick = (selectedCountry) ->
      console.log(selectedCountry)
      $scope.country = selectedCountry

    $http.get('http://ipinfo.io/geo').success (data) ->
      $scope.countryCode = (angular.fromJson data).country
      for country in $scope.flatCountries
        if country.code == $scope.countryCode.toLowerCase()
          $scope.country = country


    $scope.days = [1..31]
    $scope.months = [1..12]
    $scope.years = [1900..2014]

