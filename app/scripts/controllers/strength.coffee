'use strict'

angular.module('abeerApp')
  .controller 'StrengthCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Strength init"
    id = $routeParams.id

    if id of $rootScope.UM.strengths
      $rootScope.UM.strengths[id].visited++
    else
      $rootScope.UM.strengths[id] = {}
      $rootScope.UM.strengths[id].visited = 1

    $scope.visited = $rootScope.UM.strengths[id].visited

    $scope.url = "views/strengths/"+id+".html"
