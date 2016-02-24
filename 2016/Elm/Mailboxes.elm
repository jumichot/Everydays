import Html exposing (..)
import Html.Events exposing (..)

view : String -> Html
view greeting =
  div []
    [ button [ ] [ text "Click for English" ],
      p [ ] [ text greeting ]
    ]

inbox : Signal.Mailbox String
inbox =
  Signal.mailbox "Waiting..."

messages: Signal String
messages =
  inbox.signal

main : Signal Html
main =
  Signal.map view messages
