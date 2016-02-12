module Bingo where

import Html exposing(text)
import String


title message times =
  message ++ " "
    |> String.toUpper
    |> String.repeat times
    |> String.trimRight
    |> text

main =
  title "Bingo" 3


