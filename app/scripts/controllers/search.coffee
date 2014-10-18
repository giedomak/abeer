angular.module('abeerApp')
.controller 'SearchCtrl', ($rootScope, $scope, $location, $http) ->
  $rootScope.curTab = 'search'
  $rootScope.UM.visited_search++
  $scope.beerResults = []
  $scope.beerResultsNames = []

  $scope.searchForBeer = (query) ->
    $http.get('http://abeerfor.me/api/search?q='.concat(query).concat('&type=beer'))
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

  $scope.addPics = (results) ->
    for beer in results.data
      if not beer.labels
        beer.labels = {}
        beer.labels.icon = ""
    return results