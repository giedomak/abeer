'use strict'

angular.module('abeerApp')
  .controller 'BeerCtrl', ($routeParams, $rootScope, $scope, $http) ->
    console.log "Beers init"
    $scope.id = $routeParams.id
    $scope.beerData = {}
    $scope.retrieveData = ()  ->
      $http.get('http://www.corsproxy.com/api.brewerydb.com/v2/beer/'.concat($scope.id).concat('?key=c98568169d21ec1ca3adbea16c28ff71&format=json'))
        .success (data) ->
          $scope.beerData = data.data
          console.log($scope.beerData)
    $scope.retrieveData()

    console.log($rootScope.UM.beers_visited)

    if !$rootScope.UM.beers_visited[$scope.id]
      $rootScope.UM.beers_visited[$scope.id] = 1
    else
      $rootScope.UM.beers_visited[$scope.id]++

    $scope.defaultImg = "images/default.jpg"
