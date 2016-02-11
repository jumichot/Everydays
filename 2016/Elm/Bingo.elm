module Bingo where

import Html exposing(text)
import String

main =
  -- text(String.repeat 3 (String.toUpper("Bingo ")))
  "Bingo "
    |> String.toUpper
    |> String.repeat 3
    |> text


