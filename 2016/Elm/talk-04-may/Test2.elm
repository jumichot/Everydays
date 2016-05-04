import Graphics.Element exposing (Element, show)
import Task exposing (Task, andThen)
import Json.Decode exposing (Decoder, int, string, object3, list, object1, (:=), at, keyValuePairs, dict)
import Dict exposing(..)
import Http

type alias RepoRecord =
  { name : String
  , description : String
  , watchers_count : Int
  }

type alias OwnerRecord =
  { login : String
  , id : Int
  , avatar_url : String
  }
type alias Languages =
  Dict String Int


-- VIEW

main : Signal Element
main =
  Signal.map show mailbox.signal


-- TASK

fetchApi =
  Http.get decoder api

handleResponse data =
  Signal.send mailbox.address data
-- decoder : Decoder (Dict String Int)
-- decoder =
--   dict int
-- decoder : Decoder (List (String, Int))
-- decoder =
--   keyValuePairs int

-- ownerDecoder : Decoder OwnerRecord
-- ownerDecoder =
--   let
--     decoder = object3 OwnerRecord
--                 ("login" := string)
--                 ("id" := int)
--                 ("avatar_url" := string)
--   in
--     at ["owner"] decoder

-- repoRecordDecoder : Decoder RepoRecord
-- repoRecordDecoder =
--     object3 RepoRecord
--         ("name" := string)
--         ("description" := string)
--         ("watchers_count" := int)

fullNameDecoder : Decoder String
fullNameDecoder =
  object1 identity ("full_name" := string)

mailbox =
  Signal.mailbox []

decoder =
  at ["items"] (list fullNameDecoder)

port run : Task Http.Error ()
port run =
  fetchApi `andThen` handleResponse

api =
  "https://api.github.com/search/repositories?q=language:elm&sort=starts&language=elm"
