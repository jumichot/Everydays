import Html exposing (div, text, button)

main =
  view initialModel

initialModel = 0

view model =
  div []
    [ button [] [ text "+"]
    , div [] [ text(toString model) ]
    , button [] [text "-"]
    ]

