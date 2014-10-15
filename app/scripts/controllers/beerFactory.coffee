angular.factory "beerFactory", ($http, $q) ->
  service = {}
  baseURL = "http://www.corsproxy.com/api.brewerydb.com/v2/beer/"
  key = "?key=c98568169d21ec1ca3adbea16c28ff71&format=json"
  _beerID = ""
  _finalURL = ""
  makeURL = ->
    _finalURL = baseURL + _beerID + key
    _finalURL

  service.setBeerID = (beerID) ->
    _beerID = beerID

  service.getBeerID = ->
    _beerID

  service.callBreweryDB = ->
    makeURL()
    deferred = $q.defer()
    $http(
      method: "JSON"
      url: _finalURL
    ).success(->
      deferred.resolve data
    ).error ->
      deferred.reject "There was an error"

    deferred.promise

  service


