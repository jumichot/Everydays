import Graphics.Element exposing(..)
import Mouse
import Window
import Keyboard
import Time

main =
  -- Signal.map show Mouse.x
  -- Signal.map show Mouse.position
  Signal.map show Window.dimensions
