'use strict'

angular.module('abeerApp')
  .controller 'TypeCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Type init"
    id = $routeParams.id

    if id of $rootScope.UM.types
      $rootScope.UM.types[id].visited++
    else
      $rootScope.UM.types[id] = {}
      $rootScope.UM.types[id].visited = 1

    $scope.visited = $rootScope.UM.types[id].visited

    $scope.url = "views/types/"+id+".html"
