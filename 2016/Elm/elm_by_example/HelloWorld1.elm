module HelloWorld where

import Text as T
import Color exposing (lightRed)
import Graphics.Element exposing (..)


makeRedText : T.Text -> T.Text
makeRedText =
  T.color lightRed


main : Element
main =
  T.fromString "Hello World"
    |> makeRedText
    |> T.italic
    |> T.bold
    |> T.height 60
    |> leftAligned

