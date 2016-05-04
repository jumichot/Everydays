module RandomGif where

-- We'll define the model.  Our RandomGif component just takes a topic and the
-- url for the gif we're displaying.

type alias Model =
  { topic : String
  , gifUrl : String
  }

-- We'll define an `init` function to create our initial data - we're
-- introducing a new concept here
init : String -> (Model, Effects Action)
init topic =
  ( Model topic "assets/waiting.gif"
  , getRandomGif topic
  )

-- UPDATE

-- Our actions will be either to `RequestMore`, which asks for a new gif, and
-- `NewGif`, which responds to an incoming new gif

type Action
  = RequestMore
  | NewGif (Maybe String)


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of

-- When we request another gif, we won't update the model but we'll add a new
-- Effect that we want to take place - another call to `getRandomGif`

    RequestMore ->
      (model, getRandomGif model.topic)

-- When the Effect has completed its HTTP request, it will inject a new Action
-- with the new gif url.  This will be wrapped in a Maybe, which encapsulates
-- the idea that the http request might not have succeeded.  This is why we use
-- `Maybe.withDefault` to say that if the new maybeUrl isn't there, we will just
-- default to the existing model's gifUrl.  Finally, we don't want to introduce
-- new effects with this update, so we explicitly add an Effects.none effect to
-- our app's state.
    NewGif maybeUrl ->
      ( Model model.topic (Maybe.withDefault model.gifUrl maybeUrl)
      , Effects.none
      )
