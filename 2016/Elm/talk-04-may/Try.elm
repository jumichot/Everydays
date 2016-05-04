import Html exposing (..)
import Html.Attributes exposing (src)
import Http
import Json.Decode exposing (list, int, string, float, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Task exposing(Task, andThen)
import Debug


-- MODEL
type alias Model =
   { id : Int , name : String, response : String , photo_link : String}

initialModel = [Model -1 "hello" "YES" ""]

mailbox : Signal.Mailbox (List Model)
mailbox =
  Signal.mailbox initialModel

viewModel : Model -> Html
viewModel model = 
  (div [] 
  [ div [] [text model.name]
  , div [] [text model.response]
  , img [ src model.photo_link ] []
  ])

-- VIEW
view : List Model -> Html
view models =
  div []
  (List.map viewModel models)

-- HTTP
fetchApi =
  Http.get miam "http://localhost:3000/db"

decoder : Decoder Model
decoder =
  decode Model
  |> required "id" int
  |> required "name" string
  |> required "response" string
  |> optional "photo_link" string "mnop"

miam =
  list decoder

handleResponse data =
  let
      log = Debug.log "data" data
  in
  Signal.send mailbox.address data

port run : Task Http.Error ()
port run =
  fetchApi `andThen` handleResponse

main : Signal Html
main =
  Signal.map view mailbox.signal
