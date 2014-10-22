'use strict'

angular.module('abeerApp')
  .controller 'StrengthCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Strength init"
    id = $routeParams.id

    if id in $rootScope.strengths
      $rootScope.strengths.id.visited++
    else
      $rootScope.strengths.id = {}
      $rootScope.strengths.id.visited = 1

    $scope.visited = $rootScope.strengths.id.visited

    $scope.url = "views/strengths/"+id+".html"
