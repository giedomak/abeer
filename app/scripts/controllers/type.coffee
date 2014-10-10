'use strict'

angular.module('abeerApp')
  .controller 'TypeCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Type init"
    $scope.id = $routeParams.id
    $rootScope.types[$scope.id].visited++
