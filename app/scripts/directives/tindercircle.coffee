'use strict'

angular.module('abeerApp')
  .directive 'tindercircle', () ->
    templateUrl: "../../views/directives/tindercircle.html"
    controller: "tindercircleCtrl"

  .controller 'tindercircleCtrl', ($scope, $rootScope) ->
    console.log "tinder init"
    $(document).ready ->
      addCircle = ->
        $circle = $("<div class=\"circle\"></div>")
        $circle.animate
          width: "300px"
          height: "300px"
          "margin-top": "-150px"
          "margin-left": "-150px"
          opacity: "0"
        , 4000, "easeOutCirc"
        $("tindercircle").append $circle
        setTimeout (__remove = ->
          $circle.remove()
          return
        ), 4000
        return
      addCircle()
      setInterval addCircle, 1200
      return

