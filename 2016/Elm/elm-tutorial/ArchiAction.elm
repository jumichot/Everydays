module ArchiAction (..) where

import Mouse
import Keyboard
import Html exposing (..)
import Html.Events exposing (..)


-- MODEL


type alias Model =
  { count : Int, maximum : Int }


initialModel : Model
initialModel =
  { count = 0, maximum = 0 }



-- UPDATE


type Action
  = NoOp
  | Increment
  | Decrement
  | Reset


update : Action -> Model -> Model
update action model =
  case action of
    Increment ->
      let
        currentValue =
          model.count + 1
      in
        { model | count = currentValue , maximum = max currentValue model.maximum }

    Decrement ->
      let
        currentValue =
          model.count - 1
      in
        { model | count = currentValue, maximum = max currentValue model.maximum }

    Reset ->
      initialModel

    NoOp ->
      model



-- Mailbox : renvoie record avec une adresse et un signal
-- { address : Signal.Address Action , signal : Signal.Signal Action }


mb : Signal.Mailbox Action
mb =
  Signal.mailbox NoOp


modelSignal : Signal Model
modelSignal =
  Signal.foldp update initialModel mb.signal



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ button [ onClick address Decrement ] [ text "Decrement" ]
    , text (toString model)
    , button [ onClick address Increment ] [ text "Increment" ]
    , button [ onClick address Reset ] [ text "Reset" ]
    ]


main : Signal Html
main =
  Signal.map (view mb.address) modelSignal
