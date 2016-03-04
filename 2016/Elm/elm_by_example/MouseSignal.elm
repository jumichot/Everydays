module MouseSignal where

import Mouse
import Signal exposing (map)
import Graphics.Element exposing (show)

main : Signal Graphics.Element.Element
main =
  Signal.map show Mouse.position


