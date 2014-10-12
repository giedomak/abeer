'use strict'

angular.module('abeerApp')
  .controller 'BeerCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Beers init"
    $scope.id = $routeParams.id
    $rootScope.beers[$scope.id].visited++
    $scope.defaultImg = "images/default.jpg"
    $scope.getIndexIfObjWithOwnAttr = (value) ->
      i = 0

      while i < $rootScope.breweries.length
        return i  if $rootScope.breweries[i]['breweryID'] is value
        i++
      1