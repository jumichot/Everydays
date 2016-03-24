import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing(..)

type alias Model = Int

initialModel : Model
initialModel = 0

view address model =
  div [class "container" ] [
    button [onClick address Decrement ] [ text "Decrement" ]
    , text (toString model)
    , button [onClick address Increment ] [ text "Increment" ]
    ]

type Action = NoOp | Decrement | Increment

mailbox = Signal.mailbox NoOp

modelsSignal : Signal Model
modelsSignal =
  Signal.foldp update initialModel mailbox.signal

update action model =
  case action of
    Increment -> model + 1
    Decrement -> model - 1
    NoOp -> model

main : Signal Html
main =
  Signal.map (view mailbox.address) modelsSignal
