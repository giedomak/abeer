'use strict'

angular.module('abeerApp')
.directive 'recommendation', () ->
	templateUrl: "../../views/directives/recommendation.html"
	controller: "RecommendationCtrl"
	scope: {}

.controller 'RecommendationCtrl', ($scope, $rootScope) ->
	console.log "Rec init"
	$scope.beers = $rootScope.UM.beers_local

	# calculate the preference of each beer in the UM
	calc_preference = () ->
		for key, beer of $rootScope.UM.beers_local
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

	calc_recommendation = () ->
		# make an array of the object, so we can calculate
		beers = (val for key, val of $rootScope.UM.beers_local)

		# sort by preference
		beers.sort (a,b) ->
			return a.preference < b.preference

		# pick the top 3
		beers = beers[0..2]

		# extract features from top 3
		abv = []
		organic = []
		ibu = []
		for beer in beers
			abv.push parseFloat beer.abv
			organic.push if beer.isOrganic is "N" then 0 else 1
			ibu.push parseInt beer.ibu

		console.log abv, organic, ibu

		# calc avarage abv, organic and ibu
		total = 0
		total += val for val in abv
		abv_avg = total / abv.length

		total = 0
		total += val for val in organic
		organic_avg = Math.round(total / organic.length) is 1

		total = 0
		total += val for val in ibu
		ibu_avg = total / ibu.length

		console.log ibu_avg
		console.log abv_avg
		console.log organic_avg

		console.log beers
		$scope.beers = beers

	# calculate preference each time the UM changes
	$rootScope.$watch "UM.beers_local", () ->
		calc_preference()
		calc_recommendation()
	, true

