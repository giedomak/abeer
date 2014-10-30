'use strict'

angular.module('abeerApp')
  .directive 'sidebar', () ->
    templateUrl: "../../views/directives/sidebar.html"
    controller: "sidebarCtrl"

  .controller "sidebarCtrl" , ($scope, $rootScope) ->
    console.log "sidebar init"

    $scope.countries = [
      { name: "Africa", url: "africa" }
      { name: "Asia", url: "asia" }
      { name: "Australia", url: "australia" }
      { name: "Austria", url: "austria" }
      { name: "Belgium", url: "belgium" }
      { name: "Canada", url: "canada" }
      { name: "Caribbean", url: "caribbean" }
      { name: "Czech Republic", url: "czechrepublic" }
      { name: "England", url: "england" }
      { name: "France", url: "france" }
      { name: "Germany", url: "germany" }
      { name: "Ireland", url: "ireland" }
      { name: "Italy", url: "italy" }
      { name: "Mexico", url: "mexico" }
      { name: "Netherlands", url: "netherlands" }
      { name: "New Zealand", url: "newzealand" }
      { name: "Romania", url: "romania" }
      { name: "Scandinavia", url: "scandinavia" }
      { name: "Slovakia", url: "slovakia" }
      { name: "South America", url: "southamerica" }
      { name: "Spain & Portugal", url: "spainportugal" }
      { name: "United States", url: "unitedstates" }
      { name: "Europe (other)", url: "othereurope" }
    ]

    $scope.types = [
      { name: "Ale", url: "ale" }
      { name: "Amber", url: "amber" }
      { name: "Blonde", url: "blonde" }
      { name: "Brown", url: "brown" }
      { name: "Dark", url: "dark" }
      { name: "Fruity", url: "fruity" }
      { name: "Golden", url: "golden" }
      { name: "Lager", url: "lager" }
      { name: "Light", url: "light" }
      { name: "Pale", url: "pale" }
      { name: "Pilsner", url: "pilsner" }
      { name: "Porter", url: "porter" }
      { name: "Seasonal", url: "seasonal" }
      { name: "Stout", url: "stout" }
      { name: "Tripel", url: "tripel" }
      { name: "White", url: "white" }
    ]

    $scope.strengths = [
      { name: "Alcohol free", url: "alcoholfree" }
      { name: "Low (1-4% abv)", url: "low" }
      { name: "Typical (4-6% abv)", url: "typical" }
      { name: "High (6-10% abv)", url: "high" }
      { name: "Extreme (>10% abv)", url: "extreme" }
    ]

    # collapse in mobile view
    collapse_nav = () ->
      if (angular.element('.navbar-toggle').css('display') != 'none')
        angular.element(".navbar-toggle").trigger("click")

    angular.element(".navbar-toggle").on('click', () ->
      angular.element('.nav li a').not('.btn-link').on('click', collapse_nav)
    )