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
      age = todayYear - $scope.calendar.getFullYear()
      age--  if todayMonth < ($scope.calendar.getMonth() - 1)
      age--  if ($scope.calendar.getMonth() is todayMonth) and todayDay < $scope.calendar.getDate()
      $rootScope.UM.age = age
      if $scope.oldEnoughForCountry(age)
        $location.path("/")

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
