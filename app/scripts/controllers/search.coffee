angular.module('abeerApp')
.controller 'SearchCtrl', ($rootScope, $scope, $http) ->
  $rootScope.curTab = 'search'
  $rootScope.UM.visited_search++
  $scope.beerResults = []
  $scope.searchForBeer = (query) ->
    $http.get('http://www.corsproxy.com/api.brewerydb.com/v2/search?q='.concat(query).concat('&type=beer&key=c98568169d21ec1ca3adbea16c28ff71&format=json'))
    .success (data) ->
      console.log(beer.name for beer in data.data)
      $scope.beerResults = (beer.name for beer in data.data)


