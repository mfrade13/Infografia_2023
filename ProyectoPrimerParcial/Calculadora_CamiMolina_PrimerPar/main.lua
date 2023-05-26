-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require("composer")

-- Oculta la barra de estado del dispositivo
display.setStatusBar(display.HiddenStatusBar)

-- Configuración del ancho y alto de la pantalla
local screenWidth = display.actualContentWidth
local screenHeight = display.actualContentHeight
composer.gotoScene("calculadora")
return true

	 	