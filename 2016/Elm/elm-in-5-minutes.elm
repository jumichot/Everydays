import Html exposing (div, text, button)
import StartApp.Simple as StartApp
import Html.Events exposing (onClick)

main =
  StartApp.start
    { model = initialModel
    , view = view
    , update = update
    }

initialModel = 0

type Action = Increment | Decrement

update action model =
  case action of
    Increment ->
      model + 1
    Decrement ->
      model - 1

view address model =
  div []
  [ button [ onClick address Increment] [ text "+"]
  , div [] [ text(toString model) ]
  , button [ onClick address Decrement] [text "-"]
  ]

