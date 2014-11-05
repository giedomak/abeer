angular.module('abeerApp')
  .directive "carouselExampleItem", ($rootScope, $swipe) ->
    (scope, element, attrs) ->
      startX = null
      startY = null
      endAction = "cancel"
      carouselId = element.parent().parent().attr("id")
      translateAndRotate = (x, y, z, deg) ->
        element[0].style["-webkit-transform"] = "translate3d(" + x + "px," + y + "px," + z + "px) rotate(" + deg + "deg)"
        element[0].style["-moz-transform"] = "translate3d(" + x + "px," + y + "px," + z + "px) rotate(" + deg + "deg)"
        element[0].style["-ms-transform"] = "translate3d(" + x + "px," + y + "px," + z + "px) rotate(" + deg + "deg)"
        element[0].style["-o-transform"] = "translate3d(" + x + "px," + y + "px," + z + "px) rotate(" + deg + "deg)"
        element[0].style["transform"] = "translate3d(" + x + "px," + y + "px," + z + "px) rotate(" + deg + "deg)"
        return

      $swipe.bind element,
        start: (coords) ->
          endAction = null
          startX = coords.x
          startY = coords.y
          return

        cancel: (e) ->
          endAction = null
          translateAndRotate 0, 0, 0, 0
          e.stopPropagation()
          return

        end: (coords, e) ->
          if endAction is "prev"
            $rootScope.carouselPrev carouselId
          else $rootScope.carouselNext carouselId  if endAction is "next"
          translateAndRotate 0, 0, 0, 0
          e.stopPropagation()
          return

        move: (coords) ->
          if startX?
            deltaX = coords.x - startX
            deltaXRatio = deltaX / element[0].clientWidth
            if deltaXRatio > 0.3
              endAction = "next"
            else if deltaXRatio < -0.3
              endAction = "prev"
            else
              endAction = null
            translateAndRotate deltaXRatio * 200, 0, 0, deltaXRatio * 15
          return

      return