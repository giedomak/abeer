'use strict'

angular.module('abeerApp')
  .controller 'IncludeCtrl', ($location, $http, $routeParams, $rootScope, $scope) ->
    console.log "Include init"

    # get the name of the type for example
    if $routeParams.id then id = $routeParams.id.toLowerCase()

    # get the first part of the path. i.e. countries or types
    nav = $location.path().split("/")[1]

    # add visited to the UM
    if id of $rootScope.UM[nav]
      $rootScope.UM[nav][id].visited++
    else
      $rootScope.UM[nav][id] = {}
      $rootScope.UM[nav][id].visited = 1

    $scope.visited = $rootScope.UM[nav][id].visited

    if id
      $scope.url = "views/"+nav+"/"+id+".html"
    else
      $scope.url = "views/"+nav+".html"