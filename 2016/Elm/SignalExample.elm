import Graphics.Element exposing(..)
import Mouse
import Window
import Keyboard
import BingoUtils as Utils
import Time

import Char

-- area : (Int, Int) -> Int
-- area (w,h) =
--   w*h

-- windowArea : Signal int
-- windowArea =
--   Signal.map area Window.dimensions

-- main : Signal Element
-- main =
--   Signal.map show windowArea

-- ================================================
-- characters : Signal Char
-- characters =
--   Signal.map Char.fromCode Keyboard.presses

-- pressedDigit : Signal Bool
-- pressedDigit =
--   Signal.map Char.isDigit characters

-- main : Signal Element
-- main =
--   Signal.map show pressedDigit

-- ================================================
-- view : Int -> Int -> Element
-- view w x =
--   let
--     side =
--       if x < w // 2 then "Left" else "Right"
--   in
--     show side

-- main : Signal Element
-- main =
--   Signal.map2 view Window.width Mouse.x

-- ================================================
-- view : Int -> Int -> Element
-- view h y =
--   let
--     side =
--       if y > h // 2 then "Bottom" else "Top"
--   in
--     show side

-- main : Signal Element
-- main =
--   Signal.map2 view Window.height Mouse.y

-- ================================================
-- view : Int -> Int -> Element
-- delta : Signal Time.Time
-- delta =
--   Signal.map Time.inSeconds(Time.fps 1)

-- clickPosition : Signal (Int, Int)
-- clickPosition =
--   Signal.sampleOn delta Mouse.position

-- main : Signal Element
-- main =
--   Signal.map show clickPosition

-- ================================================
-- characters : Signal Char
-- characters =
--   Signal.map Char.fromCode Keyboard.presses

-- numbers : Signal Char
-- numbers =
  -- Signal.filter Char.isDigit '1' characters

-- noDups : Signal Char
-- noDups =
--   Signal.dropRepeats numbers


-- main : Signal Element
-- main =
--   Signal.map show noDups

-- totalNumbers : Signal Int
-- totalNumbers =
--   Signal.foldp (\number count -> count + number) 0 numbers

secondsSoFar : Signal Int
secondsSoFar =
  Signal.foldp (\_ count -> count + 1) 0 (Time.every Time.second)

main : Signal Element
main =
  Signal.map show secondsSoFar
