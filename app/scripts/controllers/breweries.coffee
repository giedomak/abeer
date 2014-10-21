angular.module('abeerApp')
.controller 'BreweriesCtrl', ($rootScope, $scope, $http) ->
  $rootScope.curTab = 'breweries'
  $rootScope.UM.visited_breweries++
  $scope.defaultImg = "images/defaultBreweryMedium.jpeg"

  $scope.basicBrewerySearch = () ->
  $http.get('http://abeerfor.me/api/breweries')
  .success (data) ->
    $scope.breweries = (brewery for brewery in data.data)
