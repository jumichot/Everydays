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

