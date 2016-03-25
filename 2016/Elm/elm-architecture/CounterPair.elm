import StartApp.Simple as StartApp
import Counter exposing(..)

import Html exposing(..)
import Html.Events exposing(..)

type alias Model =
  { topCounter : Counter.Model, bottomCounter : Counter.Model }

init : Int -> Int -> Model
init top bottom =
  { topCounter = Counter.init top, bottomCounter = Counter.init bottom }

type Action = Top Counter.Action | Bottom Counter.Action | Reset | NoOp

update : Action -> Model -> Model
update action model =
  case action of
    Reset ->
      init 0 0
    Top act ->
      { model | topCounter = Counter.update act model.topCounter }
    Bottom act ->
      { model | bottomCounter = Counter.update act model.bottomCounter }
    NoOp ->
      model


view : Signal.Address Action -> Model -> Html
view address model =
  div [] [
    Counter.view (Signal.forwardTo address Top) model.topCounter
    , Counter.view (Signal.forwardTo address Bottom) model.bottomCounter
    , button [ onClick address Reset ] [ text "Reset" ]
  ]


main : Signal Html
main =
  StartApp.start { view = view , update = update, model = init 0 0 }
