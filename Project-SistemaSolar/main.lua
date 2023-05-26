-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

CW = display.contentWidth
CH = display.contentHeight

display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"

composer.gotoScene( "splashScreen", "fade" )