module ArchiAction where

import Mouse
import Keyboard
import Html exposing (..)

type alias Model = { count : Int }

initialModel : Model
initialModel = { count = 0 }

view : Model -> Html
view model =
  text (toString model.count)


type Action = NoOp | Increment | Decrement

update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      { model | count = model.count + 1 }
    Decrement ->
      { model | count = model.count - 1 }
    NoOp ->
      model

keyPressesSignal =
  Signal.map (\_ -> Decrement) Keyboard.presses

mouseClickSignal =
  Signal.map (\_ -> Increment) Mouse.clicks

actionSignal : Signal.Signal Action
actionSignal =
  Signal.merge keyPressesSignal mouseClickSignal

modelSignal : Signal Model
modelSignal =
  Signal.foldp update initialModel actionSignal

main : Signal Html
main =
  Signal.map view modelSignal

