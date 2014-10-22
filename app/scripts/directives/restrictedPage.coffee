'use strict'

angular.module('abeerApp')
.directive 'restrictedPage', () ->
  restrict:'E',
  templateUrl: "../../views/directives/restricted-page.html"
  transclude: true
