'use strict'

angular.module('abeerApp')
.directive 'recommendation', () ->
	templateUrl: "../../views/directives/recommendation.html"
	controller: "RecommendationCtrl"

.controller 'RecommendationCtrl', ($scope, $rootScope) ->
	console.log "Rec init"

	# calculate the preference of each beer in the UM
	calc_preference = () ->
		for beer of $rootScope.UM.beers_local
			console.log beer
			beer.preference = 0.5

			# AGE
			if beer.abv
				abv = parseFloat beer.abv
				if abv > 0 and not $rootScope.UM.oldEnough
					beer.preference = 0

			# LIKE / DISLIKE
			if beer.rating
				if beer.rating is 5
					beer.preference = 1
				if beer.rating is 1
					beer.preference = 0

			# BROWSING BEHAVIOUR
			if beer.visited >= 0 then beer.preference += 0.2 * beer.visited

		console.log $rootScope.UM.beers_local

		$scope.beers = $rootScope.UM.beers_local

	# calculate preference each time the UM changes
	$rootScope.$watch "UM", () ->
		calc_preference()

