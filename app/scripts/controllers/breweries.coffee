angular.module('abeerApp')
.controller 'BreweriesCtrl', ($rootScope, $scope) ->
  $rootScope.curTab = 'breweries'
  $rootScope.UM.visited_breweries++
  $scope.defaultImg = "images/defaultBreweryMedium.jpeg"
