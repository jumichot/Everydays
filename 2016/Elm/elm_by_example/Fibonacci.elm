module Fibonacci where

import Graphics.Element exposing (..)
import List exposing ((::), map2, reverse)

fibonacci : Int -> List Int
fibonacci n =
  let
    fibonacci' n k0 k1 accu =
      if n <= 0
         then
           accu
         else
           fibonacci' (n-1) k1 (k0 + k1) (List.append accu [k1])
  in
    fibonacci' n 0 1 []

fibonacciWithIndex : Int -> List (Int, Int)
fibonacciWithIndex n =
  List.map2 (,) [0..n] (fibonacci n)


main : Element
main =
  show (fibonacciWithIndex 5)

