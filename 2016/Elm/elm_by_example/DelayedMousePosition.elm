module DelayedMousePosition where

import Graphics.Element exposing (show)
import List
import List exposing ((::), foldr, length, repeat)
import Mouse
import Signal exposing (constant)
import Signal.Extra exposing ((~), (<~))
import Time exposing (delay)
import Window



customMouseSignal : Signal (Int, Int)
customMouseSignal =
  let
    combineAndCenter (w, h) (x, y) =
      (x-w//2,h//2-y)
  in
    Signal.map2 combineAndCenter Window.dimensions Mouse.position


multiplyCustomMouseSignal : Int -> List (Signal (Int, Int))
multiplyCustomMouseSignal repetition  =
    List.repeat repetition customMouseSignal


delayPositionWithDuration :  Int -> Signal (Int, Int) -> Signal ( Int, (Int, Int) )
delayPositionWithDuration delayDuration mousePosition =
  let
    delayedPositionSignal =
      delay (toFloat delayDuration*100) mousePosition
  in
    Signal.map (\mousePosition -> (delayDuration, mousePosition)) delayedPositionSignal


combine : List (Signal a) -> Signal (List a)
combine = foldr (Signal.map2 (::)) (constant [])


delayedMousePositions : List Int -> Signal (List (Int, (Int, Int)))
delayedMousePositions delaysList =
  let
    positions = multiplyCustomMouseSignal (length delaysList)
    delayedPositions =
      List.map2 delayPositionWithDuration delaysList positions
  in
    combine delayedPositions


main =
   Signal.map show (delayedMousePositions [0,10,25])
