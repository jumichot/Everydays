module Main (..) where

import StartApp.Simple as StartApp
import Counter exposing (..)
import Html exposing (..)
import Html.Events exposing (..)


type alias Model =
  { counters : List Counter.Model, nextId : ID }


type alias ID =
  Int


type Action
  = Insert
  | Remove
  | Modify ID Counter.Action


main =
  text "Hello world"
