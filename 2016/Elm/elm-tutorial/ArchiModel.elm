module ArchiModel where

import Mouse
import Html exposing (..)

type alias Model = { count : Int }

initialModel : Model
initialModel = { count = 0 }

view : Model -> Html
view model =
  text (toString model.count)

modelSignal : Signal Model
modelSignal =
  Signal.foldp (\_ model -> { model | count = model.count + 1 }) initialModel Mouse.clicks

main : Signal Html
main =
  Signal.map view modelSignal

