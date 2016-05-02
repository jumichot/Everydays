import StartApp.Simple
import Html exposing(..)
import Html.Attributes exposing(..)


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

css : String -> Html
css path =
  node "link" [ rel "stylesheet", href path ] []

todoView : Todo -> Html
todoView todo =
  li [classList [ ("completed", todo.completed) ]]
  [ div [class "view"]
    [ input [class "toggle", type' "checkbox", checked todo.completed] []
    , label [] [ text todo.title ]
    , button [class "destroy"] []
    ]
  ]

view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ css "style.css"
  , section [class "todoapp"]
    [
      header [class "header"]
      [ h1 [] [text "Todos"]
      , input [class "new-todo", placeholder "What need to be done", autofocus True] []
      ]
    ]
  , section [ class "main" ]
    [
      ul [class "todo-list"]
      (List.map todoView model.todos)
    ]
  ]

initialModel : Model
initialModel =
  { filter = All
  , todo = { title = "", completed = False, editing = False }
  , todos = [{ title = "First", completed = False, editing = False }]
  }

main =
  StartApp.Simple.start { view = view, model = initialModel, update = update }
