module Mailboxes2 (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import StartApp.Simple as StartApp



-- MODEL
type alias Model = Int

initialModel : Model
initialModel = 0

-- UPDATE
-- Mailbox : renvoie record avec une adresse et un signal
-- { address : Signal.Address a , signal : Signal.Signal a }
mb : Signal.Mailbox Model
mb =
  Signal.mailbox initialModel


-- VIEW
view address model =
  div
    [ class "main-container" ]
    [ button [onClick address (model - 1)] [ text "Decrement" ]
    , text (toString model)
    , button [onClick address (model + 1)] [ text "Increment" ]
    ]


main =
  Signal.map (view mb.address) mb.signal
