'use strict'

angular.module('abeerApp')
.directive 'recommendation', () ->
	templateUrl: "../../views/directives/recommendation.html"
	controller: "RecommendationCtrl"
	scope: {}

.controller 'RecommendationCtrl', ($scope, $rootScope, $http) ->
	console.log "Rec init"
	$scope.beers = $rootScope.UM.beers_local
	t1 = new Date()
	first = true

	$scope.quotes = [
		"Try it, I think it really suits you!"
		"Its GOOD!"
		"This one is perfect for you"
		"And on the 7th day of Creation, God rested. And he drank this beer."
		"There once was a man from Nantucket, And before he kicked the bucket, He drank this beer, His eyes went queer, And he died with the best beer in his stomach."
		"Forget Tinder, just fool around with this beer"
		"We computed this recommendation with our Dual-Positron MD5 Hash Nuclear Enabled Quantum Leather recommendation engine. Yes, it was expensive"
		"If you don't like it, return it to the store. Just say you talked to 'Chuck' on the phone and he approved the refund"
		"The tastiest thing since sliced bread. Yeah, sliced bread tastes the same as unsliced bread, but that's not the point"
		"Tastes better than a conversation about Zwarte Piet"
		"Its AWESOME"
		"Go get it!"
		"Its delicious"
		"YUMMY"
		"Try it, you'll like it"
		"Try this one!"
		"It is tasty"
		"Have you ever considered this one?"
		"This one tastes good"
		"You won't regret this one"
		"As if an angel pisses on your tongue"
		"Yummy in your tummy"
		"Its GREAT"
		"Don't wait any longer"
	]

	$scope.quote = ""

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
			if beer.ibu then ibu.push parseInt beer.ibu

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

		# use the API to get a list with possible recommendations
		query = 'http://abeerfor.me/api/beers'
		if abv_avg then query = query.concat('?abv=').concat(abv_avg-0.5).concat(',').concat(abv_avg+0.5)
		if ibu_avg then query = query.concat('&ibu=').concat(ibu_avg-2).concat(',').concat(ibu_avg+2)
		console.log query
		$http.get(query)
		.success (data) ->
			console.log data

			# pick a random beer from a random page
			page = Math.floor (Math.random() * data.numberOfPages)

			if abv_avg or ibu_avg then char = '&' else char = '?'
			console.log query.concat(char).concat('p=').concat(page)
			$http.get(query.concat(char).concat('p=').concat(page))
			.success (data) ->
				console.log data

				# get a random beer from the page and set it as recommendation
				$scope.beer = data.data[Math.floor(Math.random()*data.data.length)]
				$scope.quote = $scope.quotes[Math.floor(Math.random()*$scope.quotes.length)]

	# calculate preference each time the UM changes
	$rootScope.$watch "UM.beers_local", (o,n) ->
		t2 = new Date()
		dif = t1.getTime() - t2.getTime()
		Seconds_from_T1_to_T2 = dif
		Seconds_Between_Dates = Math.abs(Seconds_from_T1_to_T2)
		if Seconds_Between_Dates >= 100 or first
			first = false
			calc_preference()
			calc_recommendation()
			t1 = new Date()
	, true

