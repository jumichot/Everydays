module Main (..) where

import Effects exposing (Effects, Never)
import Html
import Html.Events as Events
import Http
import StartApp
import Task


type Action
  = NoOp
  | Refresh
  | OnRefresh (Result Http.Error String)


type alias Model =
  String


view : Signal.Address Action -> Model -> Html.Html
view address message =
  Html.div
    []
    [ Html.button
        [ Events.onClick address Refresh 
        ]
        [ Html.text "Refresh" 
        ]
    , Html.text message
    ]


httpTask : Task.Task Http.Error String
httpTask =
  Http.getString "http://localhost:3000/"


refreshFx : Effects.Effects Action
refreshFx =
  httpTask
    |> Task.toResult -- the task then can never fail, return a result
    |> Task.map OnRefresh -- map avec l'action OnRefresh
    |> Effects.task


init : ( Model, Effects Action )
init =
  ( "", Effects.none )


update : Action -> Model -> ( Model, Effects.Effects Action )
update action model =
  case Debug.log "action" action of
    Refresh ->
      Debug.log "refresh :" ( model, refreshFx )

    OnRefresh result ->
      let
        message =
          Result.withDefault "" result
      in
      Debug.log " on refresh:"  ( message, Effects.none )

    _ ->
      ( model, Effects.none )


app : StartApp.App Model
app =
  StartApp.start
    { init = init
    , inputs = []
    , update = update
    , view = view
    }


main : Signal.Signal Html.Html
main =
  app.html


port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
