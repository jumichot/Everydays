import Graphics.Element exposing(..)
import Mouse
import Window
import Keyboard
import Time

area : (Int, Int) -> Int
area (w,h) =
  w*h

main : Signal Element
main =
  Signal.map show (Signal.map area Window.dimensions)
