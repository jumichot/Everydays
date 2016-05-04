import Html exposing (..)
import Http
import Json.Decode exposing (int, string, float, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
import Task exposing(Task, andThen)


-- MODEL
type alias Model =
  { ip : String , about : String }

initialModel = Model "0.0.0.0" "hello"

mailbox : Signal.Mailbox Model
mailbox =
  Signal.mailbox initialModel

-- VIEW
view : Model -> Html
view model =
  div []
  [ text (toString model.ip)
  , br [] []
  , text (toString model.about)
  ]

-- HTTP
fetchApi =
  Http.get decoder "http://jsonip.com"

decoder : Decoder Model
decoder =
  decode Model
  |> required "ip" string
  |> required "about" string

handleResponse data =
  Signal.send mailbox.address data

port run : Task Http.Error ()
port run =
  fetchApi `andThen` handleResponse

main : Signal Html
main =
  Signal.map view mailbox.signal
