angular.module('abeerApp')
.controller 'NearbyCtrl', ($rootScope, $scope, $http, $location) ->
  $rootScope.curTab = 'breweries'
  $rootScope.UM.visited_breweries++
  $scope.defaultImg = "images/defaultBreweryMedium.jpeg"
  $scope.breweryResults = []
  $scope.breweryResultsNames = []

  $scope.locality = "Amsterdam" # Default
  $scope.country = "NL"
  $scope.lat = 5.5
  $scope.long = 5.5

  $http.get('http://ipinfo.io/geo')
    .success (data) ->
      resp = angular.fromJson data
      $scope.locality = resp.city
      $scope.country = resp.country
      $scope.lat = resp.loc.split(',')[0]
      $scope.long = resp.loc.split(',')[1]
      console.log $scope.locality, $scope.country, $scope.lat
      $scope.getNearbyBreweries()

  $scope.receivedLoc = (position) ->
    console.log position

  navigator.geolocation.getCurrentPosition($scope.receivedLoc);


  $scope.getNearbyBreweries = () ->
    $http.get('http://abeerfor.me/api/locations?countryIsoCode='.concat($scope.country).concat('&locality=').concat($scope.locality))
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



  $scope.initialize = ->
    mapOptions =
      zoom: 8
      center: new google.maps.LatLng(-34.397, 150.644)

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
    return
  map = undefined
  google.maps.event.addDomListener window, "load", $scope.initialize