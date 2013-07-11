import XMonad
import XMonad.Config.Gnome
import XMonad.Actions.MouseGestures
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W
import qualified Data.Map as M

main = xmonad $ defaultConfig {
    terminal	= "urxvtc"
  , modMask	= mod4Mask
  , workspaces	= map show ['1'..'9']
  , mouseBindings = myMouseBindings
  , layoutHook = myLayout
}

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), mouseGesture gestures)
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button4), \x -> windows W.swapUp)
    , ((modm, button5), \x -> windows W.swapDown)
    ]

gestures = M.fromList $
    [ ([], (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ([L],(\w -> focus w >> screenWorkspace 0 >>= flip whenJust (windows . W.shift)))
    , ([R],(\w -> focus w >> screenWorkspace 1 >>= flip whenJust (windows . W.shift)))
    ]

myLayout = tiled
           ||| Mirror tiled
           ||| noBorders Full
           ||| noBorders tab
           ||| threeCol
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     threeCol = ThreeCol nmaster delta ratio
     tab = tabbed shrinkText defaultTheme
     -- The default number of windows in the master pane
     nmaster = 2
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 2/100
