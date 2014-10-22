'use strict'

angular.module('abeerApp')
  .controller 'StrengthCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Strength init"
    id = $routeParams.id

    if id in $rootScope.strenghts
      $rootScope.strenghts.id.visited++
    else
      $rootScope.strenghts.id = {}
      $rootScope.strenghts.id.visited = 1

    $scope.visited = $rootScope.strenghts.id.visited

    $scope.url = "views/strenghts/"+id+".html"
