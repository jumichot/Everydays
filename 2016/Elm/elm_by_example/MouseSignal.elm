module MouseSignals3 where


import Graphics.Element exposing (down, flow, leftAligned)
import List exposing (map)
import Mouse
import Signal exposing (map,sampleOn, map4)
import Text exposing (fromString)


showsignals a b c d e f g =
    flow down <|
        map (fromString >> leftAligned) [
                "Mouse.position: " ++ toString a,
                "Mouse.x: " ++ toString b,
                "Mouse.y: " ++ toString c,
                "Mouse.clicks: " ++ toString d,
                "Mouse.isDown: " ++ toString e,
                "sampleOn Mouse.clicks Mouse.position: " ++ toString f,
                "sampleOn Mouse.isDown Mouse.position: " ++ toString g
            ]


main =
