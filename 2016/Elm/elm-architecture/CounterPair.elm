import StartApp.Simple as StartApp
import Counter exposing(..)

import Html exposing(..)

main : Signal Html
main =
  StartApp.start { view = Counter.view, update = Counter.update, model = Counter.init(3) }
