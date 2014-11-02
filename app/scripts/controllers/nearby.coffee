angular.module('abeerApp')
.controller 'NearbyCtrl', ($rootScope, $scope, $http, $location) ->
  $rootScope.curTab = 'breweries'
  $rootScope.UM.visited_breweries++
  $scope.defaultImg = "images/defaultBreweryMedium.jpeg"
  $scope.breweryResultsNames = []
  $scope.breweryLocs = []


  $scope.geocoder = new google.maps.Geocoder();

  $scope.map =
    center:
      latitude: 51.470921
      longitude: 4.662819
    zoom: 10
    control: {}

  $scope.selectedBrewery = (data) ->
    $location.path("/breweries/"+data.description.id)

  $scope.getNearbyBreweries = () ->
    $http.get('http://abeerfor.me/api/locations?countryIsoCode='.concat($scope.country))
    .success (data) ->
      $scope.breweryResults = (brewery for brewery in data.data)
      $scope.breweryResultsNames = (brewery.name for brewery in data.data)
      id = 0
      $scope.breweryLocs = []
      for location in $scope.breweryResults
        location.distance = $scope.distanceToBrewery(location)
        newbrew =
          latitude: location.latitude
          longitude: location.longitude
          title: location.brewery.name
          id: id++
          options:
            animation: 2
          address: location.streetAddress
          locality: location.locality
          website: location.brewery.website
        $scope.breweryLocs.push(newbrew)
      $scope.breweryResults.sort($scope.compare)

  $scope.compare = (a,b) ->
    return a.distance - b.distance


  # convert numeric degrees to radians
  $scope.toRad = (value) ->
    return value * Math.PI / 180

  $scope.distanceToBrewery = (location) ->
    # simple distance calculation#
    # works fine for small distances
    # http://en.wikipedia.org/wiki/Equirectangular_projection
    R = 6371 # earth radius in km
    x = ($scope.toRad($scope.map.center.longitude) - $scope.toRad(location.longitude)) * Math.cos(($scope.toRad(location.latitude) + $scope.toRad($scope.map.center.latitude))/2)
    y = ($scope.toRad($scope.map.center.latitude) - $scope.toRad(location.latitude))
    return parseInt(Math.sqrt(x*x + y*y) * R)


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
    $scope.geocoder.geocode({'latLng':latlng}, (results, status) ->
      for result in results
        for listing in result['address_components']
          if "locality" in listing.types
            $scope.locality = listing.short_name
          if "country" in listing.types
            $scope.country = listing.short_name
      $scope.getNearbyBreweries()
    )


  navigator.geolocation.getCurrentPosition($scope.receivedLoc);


