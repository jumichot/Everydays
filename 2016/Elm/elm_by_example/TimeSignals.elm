module TimeSignals where


import Graphics.Element exposing (down, flow, leftAligned)
import List exposing (map)
import Mouse
import Signal
import Text exposing (fromString)
import Signal.Extra exposing ((~), (<~))
import Time exposing (delay, every, fps, fpsWhen, second, since, timestamp)


showsignals a b c d e f =
    flow down <|
        map (fromString >> leftAligned) [
                    "every (5*second): " ++ toString a,
                    "since (2*second) Mouse.clicks: " ++ toString b,
                    "timestamp Mouse.isDown: " ++ toString c,
                    "delay second Mouse.position: " ++ toString d,
                    "fps 60: " ++ toString e,
                    "fpsWhen 200 Mouse.isDown: " ++ toString f
                ]


main = showsignals
           <~ every (5*second)
           ~ since (2*second) Mouse.clicks
           ~ timestamp Mouse.isDown
           ~ delay second Mouse.position
           ~ fps 60
           ~ fpsWhen 200 Mouse.isDown
