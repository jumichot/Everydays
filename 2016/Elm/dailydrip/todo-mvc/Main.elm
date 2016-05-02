import StartApp.Simple
import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing (onKeyPress, on, targetValue)
import Debug


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
  | UpdateTitle String
  | Filter FilterState

mockTodo : Todo
mockTodo =
  { title = "A mock todo..."
  , completed = False
  , editing = False
  }

handleKeyPress : Int -> Action
handleKeyPress code =
  case code of
    13 ->
      Add mockTodo
    _ ->
      NoOp

update : Action -> Model -> Model
update action model =
  case action of
    Add todo ->
      { model | todos = todo :: model.todos
      , todo = newTodo
      }
    Complete todo ->
      model
    Delete todo ->
      model
    Filter filterState ->
      model
    UpdateTitle str ->
      let
          todo = model.todo
          updatedTodo = { todo | title = str }
      in
         {model | todo = updatedTodo }
    NoOp ->
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
      , input 
        [class "new-todo"
        , placeholder "What need to be done"
        , autofocus True
        , onKeyPress address handleKeyPress
        , value model.todo.title
        , on "input" targetValue (\str -> Signal.message address (UpdateTitle str))
        ] []
      ]
    ]
  , section [ class "main" ]
    [
      ul [class "todo-list"]
      (List.map todoView model.todos)
    ]
  ]

newTodo : Todo
newTodo =
  { title = ""
  , completed = False
  , editing = False
  }

initialModel : Model
initialModel =
  { filter = All
  , todo = newTodo
  , todos = [{ title = "First", completed = False, editing = False }]
  }

main =
  StartApp.Simple.start { view = view, model = initialModel, update = update }
