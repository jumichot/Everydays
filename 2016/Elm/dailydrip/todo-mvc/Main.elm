import StartApp.Simple exposing(start)
import Html exposing(..)


type alias Todo =
  { title : String
  , completed : Bool
  , editing : Bool
  }

type alias Todos = List Todo

type FilterState = All | Active | Completed

type alias Model =
  { todos : Todos
  , todo : Todo
  , filter : FilterState
  }

type Action
  = NoOp
  | Add Todo
  | Complete Todo
  | Delete Todo
  | Filter FilterState

update : Action -> Model -> Model
update action model =
  model

view : Signal.Address Action -> Model -> Html
view address model =
  div [] [text (toString model)]

initialModel : Model
initialModel =
  { filter = All
  , todo = { title = "Test", completed = False, editing = False }
  , todos = []
  }

main =
  start { view = view, model = initialModel, update = update }
