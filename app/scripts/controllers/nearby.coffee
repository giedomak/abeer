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

  $scope.geocoder = new google.maps.Geocoder();

  $scope.map =
    center:
      latitude: 51.470921
      longitude: 4.662819
    zoom: 10
    control: {}



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


  $scope.receivedLoc = (position) ->
    $scope.map.center =
      latitude: position.coords.latitude
      longitude: position.coords.longitude
    $scope.map.control.refresh({latitude: position.coords.latitude, longitude: position.coords.longitude})
    latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    $scope.geocoder.geocode({'latLng':latlng}, (result, status) ->
      console.log result
    )


  navigator.geolocation.getCurrentPosition($scope.receivedLoc);

  $scope.breweryLocs =
    [
      latitude: 51.4369673
      longitude: 5.4772592
      title: "Van Moll"
      id: 0
    ]

