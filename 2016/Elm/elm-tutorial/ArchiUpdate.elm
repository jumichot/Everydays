module ArchiUpdate where

import Mouse
import Html exposing (..)

type alias Model = { count : Int }

initialModel : Model
initialModel = { count = 0 }

view : Model -> Html
view model =
  text (toString model.count)


update : () -> Model -> Model
update _ model =
  { model | count = model.count + 1 }

modelSignal : Signal Model
modelSignal =
  Signal.foldp update initialModel Mouse.clicks

main : Signal Html
main =
  Signal.map view modelSignal

