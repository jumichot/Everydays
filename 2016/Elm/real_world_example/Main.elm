-- MODEL

type alias Artist = { id: Int, name: String }
type alias Model = List Artist

artist : Json.Decode.Decoder Artist
artist =
  Json.Decode.object2 Artist
    ("id" := Json.Decode.int)
    ("name" := Json.Decode.string)


init : Model
init =
  []

-- UPDATE

type Action = NoOp

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

view : Model -> Html
view model =
  div [] [text "Loading"]

actions : Signal.Mailbox Action
actions =
  Signal.mailbox NoOp

model : Signal Model
model = Signal.foldp update init actions.signal


main : Signal Html
main =
  Signal.map view model
