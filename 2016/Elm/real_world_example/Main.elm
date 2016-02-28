-- MODEL

type alias Artist = { id: Int, name: String }
type alias Model = List Artist

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
