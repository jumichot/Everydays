import Html exposing(..)
import Mouse

clickCounter =
  Signal.foldp (\_ state -> state + 1) 0 Mouse.clicks

stringClickCounter =
  Signal.map toString  clickCounter

main : Signal Html
main =
  Signal.map Html.text stringClickCounter
