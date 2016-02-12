module Bingo where

import Html exposing(text)
import String exposing(toUpper, repeat, trimRight)


title message times =
  message ++ " "
    |> toUpper
    |> repeat times
    |> trimRight
    |> text

main =
  title "Bingo" 3


