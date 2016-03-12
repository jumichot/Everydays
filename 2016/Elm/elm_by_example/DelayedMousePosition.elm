module DelayedMousePosition where

import Graphics.Element exposing (show)
import List
import List exposing ((::), foldr, length, repeat)
import Mouse
import Signal exposing (constant)
import Signal.Extra exposing ((~), (<~))
import Time exposing (delay)
import Window


combine : List (Signal a) -> Signal (List a)
combine = foldr (Signal.map2 (::)) (constant [])


centeredMousePosition : Signal (Int, Int)
centeredMousePosition =
  let
    adjust (w, h) (x, y) = (x-w//2,h//2-y)
  in
    Signal.map2 adjust Window.dimensions Mouse.position


repeatMousePositionSignal : Int -> List (Signal (Int, Int))
repeatMousePositionSignal n  =
    List.repeat n centeredMousePosition


delayedMousePositions : List Int -> Signal (List (Int, (Int, Int)))
delayedMousePositions rs =
  let
    positions = repeatMousePositionSignal (length rs)
    delayedPositions =            -- List (Signal (Int, (Int, Int))
      List.map2
      (\r pos ->
          let delayedPosition = delay (toFloat r*100) pos
          in
              (\pos -> (r,pos)) <~ delayedPosition)
      rs
      positions
  in
    combine delayedPositions


main =
   Signal.map show (delayedMousePositions [0,10,25])
