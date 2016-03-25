module Main (..) where

import StartApp.Simple as StartApp
import Counter exposing (..)
import Html exposing (..)
import Html.Events exposing (..)


type alias Model =
  { counters : List ( ID, Counter.Model ), nextId : ID }


type alias ID =
  Int

init :  Model
init =
  { counters = [], nextId = 0 }


type Action
  = Insert
  | Remove
  | Modify ID Counter.Action


update : Action -> Model -> Model
update action model =
  case action of
    Insert ->
        { model
          | counters = ( model.nextId, Counter.init 0 ) :: model.counters
          , nextId = model.nextId + 1
        }

    Remove ->
      { model | counters = List.drop 1 model.counters }

    Modify id counterAction ->
      let
        updateCounter ( counterId, counterModel ) =
          if id == counterId
             then ( counterId, Counter.update counterAction counterModel )
             else ( counterId, counterModel )
      in
        { model | counters = List.map updateCounter model.counters }


view : Signal.Address Action -> Model -> Html
view address model =
  let counters = List.map (viewCounter address) model.counters
      remove = button [ onClick address Remove ] [ text "Remove" ]
      insert = button [ onClick address Insert ] [ text "Add" ]
  in
      div [] ([remove, insert] ++ counters)

viewCounter : Signal.Address Action -> (ID, Counter.Model) -> Html
viewCounter address (id, model) =
  Counter.view (Signal.forwardTo address (Modify id)) model

main =
  StartApp.start { model = init , update = update , view = view }
