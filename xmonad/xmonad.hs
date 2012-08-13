
module Main (main) where

import XMonad hiding ( (|||) )
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.EZConfig(checkKeymap)
import System.IO
import qualified XMonad.StackSet as W

-- Hooks
import XMonad.Hooks.DynamicLog hiding (xmobar)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ServerMode

-- Layouts
import XMonad.Layout.Spiral
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Circle
import XMonad.Layout.WindowArranger
import XMonad.Layout.Accordion
import XMonad.Config.Desktop
import XMonad.Layout.Reflect
import XMonad.Layout.MultiToggle

--Themes
import XMonad.Util.Themes

--Sound
--import XMonad.Actions.Volume

main :: IO()
main = xmonad =<< mooneyConfig

--Compose separate keymaps together here.
mooneyKeymap = windowKeys
modm = mod4Mask


mooneyConfig = do
    xmobar <- spawnPipe "xmobar"
    spawn "conky"
    spawn "/home/sean/.conky/schedule.sh 0"
    {- Is this call lugging the system?
     - mapM spawn ["thunderbird", "chromium-browser"]-}
    Main.setBackground
    return $ defaultConfig
        { workspaces            = ["home", "var", "dev", "mail", "web", "doc", "multimedia"] ++
                                    map show [8 .. 9 :: Int] 
        , borderWidth           = 2
        , normalBorderColor     = "#cccccc"
        , focusedBorderColor    = "#11cc34"
        , focusFollowsMouse     = False
        , terminal              = "gnome-terminal"
        , modMask               = modm
        , manageHook            = newManageHook
        , logHook               = myDynLog xmobar
        , layoutHook            = avoidStruts $ 
                                  --decorated
                                  allLays
        , handleEventHook       = serverModeEventHook
        --, startupHook           = return () >> checkKeymap mooneyConfig mooneyKeymap
        } `additionalKeys` mooneyKeymap
        where
            --layouts
            tiled       = Tall 1 (3/100) (1/2)
            spr         = spiralWithDir East CW (6/7)
            mytabs      = tabbed shrinkText (theme smallClean)
            --decorated   = simpleFloat' shrinkText (theme smallClean)
            allLays   = windowArrange $
                           ( tiled 
                            ||| spr 
                            ||| noBorders mytabs
                            ||| noBorders Full
                           -- ||| Mirror tiled   
                           -- ||| Circle
                           )

            --manageHook
            myManageHook = composeAll [ resource =? "win"          --> doF (W.shift "doc") --xpdf??
                                        , resource =? "chromium-browser" --> doF (W.shift "web")
                                        , className =? "Thunderbird" --> doF (W.shift "mail")
                                       , className =? "Eclipse" --> doF (W.shift "dev")
                                       , className =? "Pithos" --> doF(W.shift "multimedia")
                                       , className =? "JabRef" --> doF (W.shift "doc")
                                       ]
            newManageHook = myManageHook

            -- xmobar
            myDynLog    h = dynamicLogWithPP defaultPP
                            { ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
                            , ppTitle   = xmobarColor "green"  "" . shorten 40
                            , ppVisible = wrap "(" ")"
                            , ppOutput = hPutStrLn h
                            }

pictures = "/home/sean/Pictures"
--bgimage = pictures ++ "/1440x900/HDFlare.jpg"
--bgimage = pictures ++ "/1600x1200/TechnoBlack.jpg"
--bgimage = pictures ++ "/1440x900/forrest.jpg"
bgimage = pictures ++ "/1680x1050/Stitched_Up.png"
bgprog = "feh --bg-scale "
setBackground = spawn $ bgprog ++ bgimage

windowKeys = []
{- the REFLECTX,Y seems to be broken and crashes when looping around on the list of layouts.
 - Not using is, so not using these key bindings.
[  ((modm .|. controlMask, xK_x), sendMessage $ Toggle REFLECTX)
              , ((modm .|. controlMask, xK_y), sendMessage $ Toggle REFLECTY)
              ]-}
