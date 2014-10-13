'use strict'

angular.module('abeerApp')
  .directive 'sidebar', () ->
    templateUrl: "../../views/sidebar.html"
    controller: "sidebarCtrl"

  .controller "sidebarCtrl" , ($scope, $rootScope) ->
    console.log "sidebar init"

    collapse_nav = () ->
      if (angular.element('.navbar-toggle').css('display') != 'none')
        angular.element(".navbar-toggle").trigger("click")

    angular.element(".navbar-toggle").on('click', () ->
      angular.element('.nav li a').not('.btn-link').on('click', collapse_nav)
    )