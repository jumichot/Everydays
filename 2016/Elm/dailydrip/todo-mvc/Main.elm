import StartApp.Simple
import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing (onKeyPress, on, targetValue, targetChecked)
import Debug


type alias Todo =
  { title : String
  , completed : Bool
  , editing : Bool
  , identifier : Int
  }

type alias Todos = List Todo

type FilterState = All | Active | Completed

type alias Model =
  { todos : Todos
  , todo : Todo
  , filter : FilterState
  , nextIdentifier : Int
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
  , identifier = 15
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
      , nextIdentifier = model.nextIdentifier + 1
      }
    Complete todo ->
      let
        updateTodo thisTodo =
          if thisTodo.identifier == todo.identifier then
            { todo | completed = True }
          else
            thisTodo
      in
        {model | todos = List.map updateTodo model.todos }
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

todoView : Signal.Address Action -> Todo -> Html
todoView address todo =
  li [classList [ ("completed", todo.completed) ]]
  [ div [class "view"]
    [ input 
      [class "toggle"
      , type' "checkbox"
      , on "change" targetChecked (\bool -> Signal.message address (Complete todo))
      , checked todo.completed
      ] []
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
      (List.map (todoView address) model.todos)
    ]
  ]

newTodo : Todo
newTodo =
  { title = ""
  , completed = False
  , editing = False
  , identifier = 0
  }

initialModel : Model
initialModel =
  { filter = All
  , todo = { newTodo | identifier = 2 }
  , todos = [{ title = "First", completed = False, editing = False, identifier = 1 }]
  , nextIdentifier = 3
  }

main =
  StartApp.Simple.start { view = view, model = initialModel, update = update }
