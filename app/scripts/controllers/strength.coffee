'use strict'

angular.module('abeerApp')
  .controller 'StrengthCtrl', ($routeParams, $rootScope, $scope) ->
    console.log "Strength init"
    $scope.id = $routeParams.id
    $rootScope.strengths[$scope.id].visited++
