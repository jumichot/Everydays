module FibonacciBars where

import Graphics.Element exposing(..)
import Fibonacci exposing(fibonacciWithIndex)
import Color exposing (blue, brown, green, orange, purple, red, yellow)
import Graphics.Collage exposing (collage, filled, rect)
import Graphics.Element exposing (down, flow, right, show)
import List exposing (drop, head, length, map)
import Maybe exposing (withDefault)


color n =
    let colors = [ red, orange, yellow, green, blue, purple, brown ]
    in
        drop (n % (length colors)) colors |> head |> withDefault red


bar (index, n) =
    let
      scale = 30
      rectWidth = (toFloat n * scale)
      rectHeight = scale
      rectShape = rect rectWidth  rectHeight
      rectForm =  filled (color index) rectShape
    in
    flow right [ collage (round rectWidth) rectHeight [rectForm], show n ]


main =
  -- flow down (map bar (fibonacciWithIndex 10)) the two are equivalent
  flow down <| map bar (fibonacciWithIndex 10)
