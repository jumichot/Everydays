module Bingo where

import Html exposing(..)
import Html.Attributes exposing(..)
import Html.Events exposing(..)

import String exposing(toUpper, repeat, trimRight)
import Signal exposing(Address)
import StartApp.Simple as StartApp
import BingoUtils as Utils

import Debug

-- MODEL
type alias Entry =
  { phrase: String
  , points: Int
  , wasSpoken: Bool
  , id: Int
  }


newEntry : String -> Int -> Int -> Entry
newEntry phrase points id =
  Entry phrase points False id

type alias Model =
  { entries : List Entry
  , phraseInput: String
  , pointsInput: String
  , nextId : Int
  }

initialModel : Model
initialModel =
  { entries =
    [ newEntry "Future-Proof" 100 1
    , newEntry "In the cloud" 300 3
    , newEntry "Doing Agile" 200 2
    , newEntry "Rock-Star Ninja" 400 4
    ]
  , phraseInput = ""
  , pointsInput = ""
  , nextId = 5
  }

-- UPDATE
-- describe possible action possible on a model
-- it's just data
type Action
  = NoOp
  | Sort
  | Delete Int
  | Mark Int
  | UpdatePhraseInput String
  | UpdatePointsInput String


update : Action -> Model -> Model
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
    UpdatePhraseInput contents ->
      { model | phraseInput = contents }
    UpdatePointsInput contents ->
      { model | pointsInput = contents }




-- VIEW
title : String -> Int-> Html
title message times =
  message ++ " "
    |> toUpper
    |> repeat times
    |> trimRight
    |> text


pageHeader : Html
pageHeader =
  h1 [ ] [ title "Bingo !" 3 ]


pageFooter : Html
pageFooter =
  footer [ ]
    [ a [ href "http://julienmichot.fr" ]
        [ text "Julien Michot website" ] ]



entryItem : Address Action -> Entry -> Html
entryItem address entry =
  li
    [ classList [ ("highlight", entry.wasSpoken) ]
    , onClick address (Mark entry.id)
    ]
    [ span [ class "phrase" ] [ text entry.phrase ]
    , span [ class "points" ] [ text (toString entry.points) ]
    , button [ class "delete", onClick address (Delete entry.id) ] [ ]
    ]

totalPoint : List Entry -> Int
totalPoint entries =
  entries
    |> List.filter .wasSpoken
    |> List.foldl (\e sum -> sum + e.points) 0


totalItem : Int -> Html
totalItem total =
  li
    [ class "total" ]
    [ span [ class "label" ] [ text "Total" ]
    , span [ class "points" ] [ text (toString total) ]
    ]

entryList : Address Action -> List Entry -> Html
entryList address entries =
  let
    entryItems = List.map (entryItem address) entries
    items = entryItems ++ [totalItem (totalPoint entries)]
  in
    ul [ ] items

entryForm : Address Action -> Model -> Html
entryForm address model =
  div [ ]
  [ input
      [ type' "text"
      , placeholder "Phrase"
      , value model.phraseInput
      , name "phrase"
      , autofocus True
      , Utils.onInput address UpdatePhraseInput
      ]
      [ ]
  , input
      [ type' "number"
      , placeholder "Points"
      , value model.pointsInput
      , name "points"
      , Utils.onInput address UpdatePointsInput
      ]
      [ ]
  , button [ class "add" ] [ text "Add" ]
  , h2
      [ ]
      [ text (model.phraseInput ++ " " ++ model.pointsInput) ]
  ]

view : Address Action -> Model -> Html
view address model =
  div [ id "container" ]
    [ pageHeader
    , entryForm address model
    , entryList address model.entries
    , button [ class "sort", onClick address Sort ] [ text "Sort" ]
    , pageFooter
    ]

-- WIRED IT ALL TOGETHER

main: Signal Html
main =
  StartApp.start { model = initialModel, view = view, update = update }

