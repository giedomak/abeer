'use strict'

angular.module('abeerApp')
  .controller 'TypeCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Type init"
    id = $routeParams.id

    if id in $rootScope.types
      $rootScope.types.id.visited++
    else
      $rootScope.types.id = {}
      $rootScope.types.id.visited = 1

    $scope.visited = $rootScope.types.id.visited

    $scope.url = "views/types/"+id+".html"
