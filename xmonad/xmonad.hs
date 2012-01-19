
{-#
   LANGUAGE
    NoMonomorphismRestriction
   #-}

module Main (main) where

import XMonad hiding ( (|||) )
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(checkKeymap, additionalKeysP)
--import XMonad.Util.Dzen
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M

-- Actions
import XMonad.Actions.Volume(toggleMute, raiseVolume, lowerVolume)

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

--workspaceAssignments = [("win", "doc"), ("firefox", "web"), ("chromium-browser", "web"), ("amarok", "multimedia")]

--alert = dzenConfig return . show

mooneyConfig = do
    Main.setBackground
    xmobar <- spawnPipe "xmobar"
    spawn "conky"
    spawn "/home/sean/.conky/calendar/calendar.sh"
    return $ defaultConfig
        { workspaces            = ["home", "var", "dev", "mail", "web", "doc", "media"] ++
                                    map show [8 .. 9 :: Int] 
        , borderWidth           = 2
        , normalBorderColor     = "#cccccc"
        , focusedBorderColor    = "#11cc34"
        , focusFollowsMouse     = False
        , terminal              = "gnome-terminal"
        , modMask               = mod4Mask
--        , keys                  = newKeys
        , manageHook            = newManageHook
        , logHook               = myDynLog xmobar
        , layoutHook            = avoidStruts $ 
                                  --decorated
                                  allLays
        , handleEventHook       = serverModeEventHook
        } `additionalKeysP` (mediaKeys ++ utilityKeys ++ wmKeys)
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

            --manageHook
            myManageHook = composeAll [ resource =? "win"          --> doF (W.shift "doc") --xpdf??
                                        , resource =? "firefox" --> doF (W.shift "web")
                                        , resource =? "chromium-browser" --> doF (W.shift "web")
                                        , className =? "Thunderbird" --> doF (W.shift "mail")
                                        , resource =? "amarok" --> doF (W.shift "media")
                                        , className =? "android" --> doFloat
                                        , className =? "Gimp" --> doFloat
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
{-            home = "home"
            var = "var"
            dev = "dev"
            mail = "mail"
            web = "web"
            doc = "doc"
            mmedia = "multimedia" -}

mediaKeys = [  ("<XF86AudioLowerVolume>",  lowerVolume 3 >> return ())
              ,("<XF86AudioRaiseVolume>",  raiseVolume 3 >> return ())
              ,("<XF86AudioMute>",         toggleMute >> return ())
            ]

utilityKeys = [ ("<XF86Calculator>" , calculator)
               ,("<XF86WWW>"        , webbrowser)
               ,("M-x w"            , webbrowser)
               ,("M-x t"            , email)
               ,("M-x e"            , ide)
               ,("M-x a"            , musicplayer)
              ]

--Window Management
wmKeys = [ (w ++ " s", sendMessage $ JumpToLayout "Spiral") 
          ,(w ++ " t", sendMessage $ JumpToLayout "Tall")
          ,(w ++ " f", sendMessage $ JumpToLayout "Full")
        ] where w ="M-v"

--bgImageName = "/home/sean/Pictures/78215-corridor.JPG "
bgImageName = "/home/sean/Pictures/99076-2222.jpg"
--bgImageName = "/home/sean/Pictures/backgrounds/Power_of_Words_by_Antonio_Litterio.jpg"
--bgImageName = "/home/sean/Pictures/backgrounds/haskellwp.png"
setBackground = spawn $ "feh --bg-scale " ++ bgImageName

calculator  = spawn "gnome-calculator"
webbrowser  = spawn "chromium-browser"
email       = spawn "thunderbird"
ide         = spawn "eclipse"
musicplayer = spawn "amarok"

