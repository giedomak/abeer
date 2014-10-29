'use strict'

angular.module('abeerApp')
.directive 'recommendation', () ->
	templateUrl: "../../views/directives/recommendation.html"
	controller: "RecommendationCtrl"

.controller 'RecommendationCtrl', ($scope) ->
	console.log "Rec init"

	$scope.beer = {}
	$scope.beer.name = "BEEEEER"
