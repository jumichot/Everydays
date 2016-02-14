module Bingo where

import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing(..)

import String exposing(toUpper, repeat, trimRight)

import StartApp.Simple as StartApp

import Debug

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
  | Delete Int
  | Mark Int

update action model =
  case action of
    NoOp ->
      model
    Sort ->
      { model | entries = List.sortBy .points model.entries }
    Delete id ->
      let remainingEntries =
        Debug.log "RemainingEntries" (List.filter (\e -> e.id /= id) model.entries)
      in
        { model | entries = remainingEntries }
    Mark id ->
      let
        entryToggleSpoken e =
          { e | wasSpoken = (not e.wasSpoken) }
        updateEntry e =
          if e.id == id then entryToggleSpoken e else e
      in
        { model | entries = List.map updateEntry model.entries }




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



entryItem address entry =
  li 
    [ classList [ ("highlight", entry.wasSpoken) ]
    , onClick address (Mark entry.id)
    ]
    [ span [ class "phrase" ] [ text entry.phrase ]
    , span [ class "points" ] [ text (toString entry.points) ]
    , button [ class "delete", onClick address (Delete entry.id) ] [ ]
    ]

totalPoint entries =
  entries
  |> List.filter .wasSpoken
  |> List.map .points
  |> List.sum

totalItem total =
  li
    [ class "total" ]
    [ span [ class "label" ] [ text "Total" ]
    , span [ class "points" ] [ text (toString total) ]
    ]

entryList address entries =
  let
    entryItems = List.map (entryItem address) entries
    items = entryItems ++ [totalItem (totalPoint entries)]
  in
    ul [ ] items


view address model =
  div [ id "container" ]
    [ pageHeader
    , entryList address model.entries
    , button [ class "sort", onClick address Sort ] [ text "Sort" ]
    , pageFooter
    ]

-- WIRED IT ALL TOGETHER

main =
  StartApp.start { model = initialModel, view = view, update = update }

