module HelloWorld where

import Text
import Color exposing (lightRed)
import Graphics.Element exposing (..)

main : Element
main =
  Text.fromString "Hello World"
    |> Text.color lightRed
    |> Text.italic
    |> Text.bold
    |> Text.height 60
    |> leftAligned

