import Html exposing (..)
import Task exposing(Task, andThen)
import Json.Decode exposing (Decoder, int, string, object1, object3, (:=), at, keyValuePairs)

import Http

-- MODEL
type alias Model =
  { ip : String }

mailbox =
  Signal.mailbox (Model "0.0.0.0")

-- VIEW
view : Model -> Html
view model =
  text (toString model)

-- API
api = "http://jsonip.com/"

decoder : Decoder Model
decoder =
    object1 Model
        ("ip" := string)

fetchApi =
  Http.get decoder api

handleResponse data =
  Signal.send mailbox.address data

port run : Task Http.Error ()
port run =
  fetchApi `andThen` handleResponse

main : Signal Html
main =
  Signal.map view mailbox.signal
