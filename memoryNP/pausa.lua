local composer = require("composer")
local scene = composer.newScene()

-- Función para manejar el evento de clic en el botón "Resume"
local function resumeButtonClick(event)
    if event.phase == "ended" then
        composer.hideOverlay("fade", 400) -- Ocultar la escena de pausa
    end
    return true
end

-- Función para manejar el evento de clic en el botón "Volver a la pantalla principal"
local function volverButtonClick(event)
    if event.phase == "ended" then
        composer.removeScene("game") -- Eliminar la escena de juego actual
        composer.gotoScene("menu", { effect = "fade", time = 400 }) -- Ir a la escena de menu.lua
    end
    return true
end

function scene:create(event)
    local sceneGroup = self.view

    -- Crea el fondo de la pausa
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0, 0, 0, 0.75)

    -- Crea el título de la pausa
    local title = display.newText({
        parent = sceneGroup,
        text = "Pausa",
        x = display.contentCenterX,
        y = display.contentCenterY - 50,
        font = native.systemFontBold,
        fontSize = 24
    })

    -- Crea el botón "Resume"
    local resumeButton = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY, 150, 40, 10)
    resumeButton:setFillColor(0, 181/255, 204/255)
    resumeButton.strokeWidth = 2
    resumeButton:setStrokeColor(0, 0, 0)

    local resumeButtonText = display.newText({
        parent = sceneGroup,
        text = "Resume",
        x = resumeButton.x,
        y = resumeButton.y,
        font = "Helvetica",
        fontSize = 16
    })
    resumeButtonText:setFillColor(1, 1, 1)

    -- Agregar sombra al botón "Resume"
    local resumeShadow = display.newRoundedRect(sceneGroup, resumeButton.x, resumeButton.y, resumeButton.width, resumeButton.height, 10)
    resumeShadow.fill = {0, 0, 0, 0.5}
    resumeShadow.x = resumeButton.x + 2
    resumeShadow.y = resumeButton.y + 2
    resumeShadow.strokeWidth = 0
    resumeShadow:toBack()

    resumeButton:addEventListener("touch", resumeButtonClick)

    -- Crea el botón "Volver a la pantalla principal"
    local volverButton = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY + 60, 220, 40, 10)
    volverButton:setFillColor(0, 181/255, 204/255)
    volverButton.strokeWidth = 2
    volverButton:setStrokeColor(0, 0, 0)

    local volverButtonText = display.newText({
        parent = sceneGroup,
        text = "Volver a la pantalla principal",
        x = volverButton.x,
        y = volverButton.y,
        font = "Helvetica",
        fontSize = 16
    })
    volverButtonText:setFillColor(1, 1, 1)

    -- Agregar sombra al botón "Volver a la pantalla principal"
    local volverShadow = display.newRoundedRect(sceneGroup, volverButton.x, volverButton.y, volverButton.width, volverButton.height, 10)
    volverShadow.fill = {0, 0, 0, 0.5}
    volverShadow.x = volverButton.x + 2
    volverShadow.y = volverButton.y + 2
    volverShadow.strokeWidth = 0
    volverShadow:toBack()

    volverButton:addEventListener("touch", volverButtonClick)
end

scene:addEventListener("create", scene)

return scene
