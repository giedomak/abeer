angular.module('abeerApp')
.controller 'BreweriesCtrl', ($rootScope, $scope, $http, $location) ->
  $rootScope.curTab = 'breweries'
  $rootScope.UM.visited_breweries++
  $scope.defaultImg = "images/defaultBreweryMedium.jpeg"
  $scope.breweryResults = []
  $scope.breweryResultsNames = []

  $http.get('http://abeerfor.me/api/breweries')
    .success (data) ->
      $scope.breweries = (brewery for brewery in data.data)

  $scope.selectedBrewery = (data) ->
    $location.path("/breweries/"+data.description.id)

  $scope.searchForBrewery = (query) ->
    $http.get('http://abeerfor.me/api/search?q='.concat(query).concat('&type=brewery'))
    .success (data) ->
      $scope.breweryResults = (brewery for brewery in data.data)
      $scope.breweryResultsNames = (brewery.name for brewery in data.data)


  $scope.getBreweryWithName = (value) ->
    i = 0
    while i < $scope.breweryResults.length
      return i  if $scope.breweryResults[i]['name'] is value
      i++
    return i


  $scope.loadBreweryPage = (brewery) ->
    $location.path("/breweries/"+ $scope.breweryResults[$scope.getBreweryWithName(brewery)]['id'])

  $scope.addPics = (results) ->
    for brewery in results.data
      if not brewery.labels
        brewery.labels = {}
        brewery.labels.icon = ""
    return results
