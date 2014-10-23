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
    ]

    $scope.types = [
      { name: "Ale", url: "ale" }
      { name: "Amber", url: "amber" }
      { name: "Blonde", url: "blonde" }

    ]

    $scope.strengths = [
      { name: "Alcohol free", url: "alcoholfree" }
      { name: "Low (1-4%)", url: "low" }
    ]

    # collapse in mobile view
    collapse_nav = () ->
      if (angular.element('.navbar-toggle').css('display') != 'none')
        angular.element(".navbar-toggle").trigger("click")

    angular.element(".navbar-toggle").on('click', () ->
      angular.element('.nav li a').not('.btn-link').on('click', collapse_nav)
    )