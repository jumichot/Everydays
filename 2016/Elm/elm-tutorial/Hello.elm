module Hello where

import Html exposing(text, div)
import Html.Attributes exposing(class)

add : number -> number -> number
add x y =
  x + y


main =
  let
      content =
        add 2 3
        |> toString
        |> text
  in
    div []
      [
      div [class "welcome-message"] [content]
      , div [class "welcome-message"] [content]
      ]
