import StartApp.Simple exposing(start)
import Html exposing(..)

type alias Model = Int
type Action = NoOp

update : Action -> Model -> Model
update action model =
  model


view : Signal.Address Action -> Model -> Html
view address model =
  div [] [text (toString model)]

initialModel : Model
initialModel = 0

main =
  start { view = view, model = initialModel, update = update }
