angular.module('abeerApp')
.controller 'SearchCtrl', ($rootScope, $scope, $location, $http) ->
  $rootScope.curTab = 'search'
  $rootScope.UM.visited_search++
  $scope.beerResults = []
  $scope.beerResultsNames = []

  $scope.searchForBeer = (query) ->
    $http.get('http://www.corsproxy.com/api.brewerydb.com/v2/search?q='.concat(query).concat('&type=beer&key=c98568169d21ec1ca3adbea16c28ff71&format=json'))
    .success (data) ->
      $scope.beerResults = (beer for beer in data.data)
      $scope.beerResultsNames = (beer.name for beer in data.data)


  $scope.getBeerWithName = (value) ->
    i = 0
    while i < $scope.beerResults.length
      return i  if $scope.beerResults[i]['name'] is value
      i++
    return i


  $scope.loadBeerPage = (beer) ->
    $location.path("/beers/"+ $scope.beerResults[$scope.getBeerWithName(beer)]['id'])

