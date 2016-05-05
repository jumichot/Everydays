import Html exposing (..)
import Html.Attributes exposing (src)
import Http
import Task exposing(Task, andThen)
import Json.Decode exposing (object1, object2, (:=), list, int, string, float, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

-- Model
type alias Model = 
   { id : Int , name : String, response : String , photo_link : String}

initialModel = [Model -1 "hello" "YES" ""]


mailbox : Signal.Mailbox (List Model)
mailbox =
  Signal.mailbox initialModel

viewModel : Model -> Html
viewModel model =
  div []
  [text model.name
  , text model.response
  , img [ src model.photo_link ] []
  ]

-- VIEW
view : List Model -> Html
view models =
  div []
  (List.map viewModel models)


-- API
fetchApi : Task Http.Error (List Model)
fetchApi =
  Http.get listDecoder "http://localhost:3000/db"

decoder : Decoder Model
decoder =
  decode Model
  |> required "id" int
  |> required "name" string
  |> required "response" string
  |> optional "photo" string "http://placehold.it/350x150"

listDecoder=
  list decoder

callback data =
  Signal.send mailbox.address data

port run : Task Http.Error ()
port run =
  fetchApi `andThen` callback

main : Signal Html
main =
  Signal.map view mailbox.signal
