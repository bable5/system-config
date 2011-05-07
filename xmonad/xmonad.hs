
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
import XMonad.Layout.WindowArranger
import XMonad.Layout.Accordion
import XMonad.Config.Desktop

--Themes
import XMonad.Util.Themes

main :: IO()
main = xmonad =<< mooneyConfig

mooneyKeymap = []

mooneyConfig = do
    xmobar <- spawnPipe "xmobar"
    return $ defaultConfig
        { workspaces            = ["home", "var", "dev", "mail", "web", "doc", "multimedia"] ++
                                    map show [8 .. 9 :: Int] 
        , borderWidth           = 2
        , normalBorderColor     = "#cccccc"
        , focusedBorderColor    = "#11cc34"
        , focusFollowsMouse     = False
        , terminal              = "gnome-terminal"
        , modMask               = mod4Mask
        , manageHook            = newManageHook
        , logHook               = myDynLog xmobar
        , layoutHook            = avoidStruts $ 
                                  --decorated
                                  allLays
        , handleEventHook       = serverModeEventHook
        , startupHook           = return () >> checkKeymap mooneyConfig mooneyKeymap
        } 
        where
            --layouts
            tiled       = Tall 1 (3/100) (1/2)
            spr         = spiralWithDir East CW (6/7)
            mytabs      = tabbed shrinkText (theme smallClean)
            --decorated   = simpleFloat' shrinkText (theme smallClean)
            allLays   = windowArrange $
                            tiled 
                            ||| spr 
                            ||| noBorders mytabs
                            ||| noBorders Full
                            ||| Mirror tiled   
                                       
                          --  ||| Accordion

            --manageHook
            myManageHook = composeAll [ resource =? "win"          --> doF (W.shift "doc") --xpdf??
                                        , resource =? "chromium-browser" --> doF (W.shift "web")
                                        , className =? "Thunderbird" --> doF (W.shift "mail")
                                       , className =? "Eclipse" --> doF (W.shift "dev")
                                       ]
            newManageHook = myManageHook

            -- xmobar
            myDynLog    h = dynamicLogWithPP defaultPP
                            { ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
                            , ppTitle   = xmobarColor "green"  "" . shorten 40
                            , ppVisible = wrap "(" ")"
                            , ppOutput = hPutStrLn h
                            }


