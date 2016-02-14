module Bingo where

import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing(..)

import String exposing(toUpper, repeat, trimRight)

import StartApp.Simple as StartApp

-- MODEL

newEntry phrase points id =
  {
    phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }

initialModel =
  { entries =
    [ newEntry "Future-Proof" 100 1
    , newEntry "In the cloud" 300 3
    , newEntry "Doing Agile" 200 2
    , newEntry "Rock-Star Ninja" 400 4
    ]
  }

-- UPDATE
-- describe possible action possible on a model
-- it's just data
type Action
  = NoOp
  | Sort

update action model =
  case action of
    NoOp ->
      model
    Sort ->
      { model | entries = List.sortBy .points model.entries }

-- VIEW

title message times =
  message ++ " "
    |> toUpper
    |> repeat times
    |> trimRight
    |> text


pageHeader =
  h1 [ ] [ title "Bingo !" 3 ]


pageFooter =
  footer [ ]
    [ a [ href "http://julienmichot.fr" ]
        [ text "Julien Michot website" ] ]



entryItem entry =
  li [ ]
    [ span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ]
    ]

entryList entries =
  ul [ ] (List.map entryItem entries)


view address model =
  div [ id "container" ]
    [ pageHeader
    , entryList model.entries
    , button [ class "sort", onClick address Sort ] [ text "Sort" ]
    , pageFooter
    ]

-- WIRED IT ALL TOGETHER

main =
  StartApp.start { model = initialModel, view = view, update = update }

