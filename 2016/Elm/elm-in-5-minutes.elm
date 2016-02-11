import Html exposing (div, text, button)

main =
  div []
    [ button [] [ text "+"]
    , div [] [ text "0" ]
    , button [] [text "-"]
    ]

