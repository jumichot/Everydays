module ArchiAction where

import Mouse
import Html exposing (..)

type alias Model = { count : Int }

initialModel : Model
initialModel = { count = 0 }

view : Model -> Html
view model =
  text (toString model.count)


type Action = NoOp | Increment

update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      { model | count = model.count + 1 }
    NoOp ->
      model


actionSignal : Signal.Signal Action
actionSignal =
  Signal.map (\_ -> Increment) Mouse.clicks

modelSignal : Signal Model
modelSignal =
  Signal.foldp update initialModel actionSignal

main : Signal Html
main =
  Signal.map view modelSignal

