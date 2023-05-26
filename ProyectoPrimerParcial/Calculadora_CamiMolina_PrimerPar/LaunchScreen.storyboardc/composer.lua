local composer = require("composer")

-- Oculta la barra de estado del dispositivo
display.setStatusBar(display.HiddenStatusBar)

-- Configuración del ancho y alto de la pantalla
local screenWidth = display.actualContentWidth
local screenHeight = display.actualContentHeight

-- Configuración de la escena inicial
composer.gotoScene("calculadora")

-- Devuelve true para evitar que Solar2D cargue la pantalla de inicio predeterminada
return true
