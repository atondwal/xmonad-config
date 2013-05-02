import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.MouseGestures
import qualified XMonad.StackSet as W
import qualified Data.Map as M

main = xmonad $ defaultConfig {
    terminal	= "urxvtc"
  , modMask	= mod4Mask
  , workspaces	= map show ['1'..'9']
  , mouseBindings = myMouseBindings
}

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), mouseGesture gestures)
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button4), (\w -> focus w >> windows W.swapUp))
    , ((modm, button5), (\w -> focus w >> windows W.swapDown))
    ]

gestures = M.fromList $
    [ ([], (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ([L],(\w -> focus w >> screenWorkspace 0 >>= flip whenJust (windows . W.shift)))
    , ([R],(\w -> focus w >> screenWorkspace 1 >>= flip whenJust (windows . W.shift)))
    ]
