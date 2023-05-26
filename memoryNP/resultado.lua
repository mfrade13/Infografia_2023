local composer = require("composer")

-- Definir la escena de victoria
local scene = composer.newScene()

-- Crear la escena de victoria
function scene:create(event)
    local sceneGroup = self.view

    -- Crear fondo
    local background = display.newRect(sceneGroup, display.contentCenterX,
                                       display.contentCenterY,
                                       display.actualContentWidth,
                                       display.actualContentHeight)
    background.fill = {type = "image", filename = "fondo.png"} -- Establecer la imagen de fondo

    -- Crear imagen de victoria
    local victoryImage = display.newImage(sceneGroup, "ganaste.png")
    victoryImage.x = display.contentCenterX
    victoryImage.y = display.contentCenterY

    -- Crear botón "Volver a la pantalla principal"
    local backButton = display.newRect(sceneGroup, display.contentCenterX, display.contentHeight - 50, 200, 50)
    backButton:setFillColor(0, 181/255, 204/255)

    local backButtonText = display.newText({
        parent = sceneGroup,
        text = "Pantalla Principal",
        x = backButton.x,
        y = backButton.y,
        font = native.systemFont,
        fontSize = 20
    })
    backButtonText:setFillColor(1, 1, 1) -- Establecer el color del texto del botón

    -- Función para manejar el evento de clic en el botón "Volver a la pantalla principal"
    local function backButtonClick(event)
        if event.phase == "ended" then
            composer.gotoScene("menu", {effect = "fade", time = 400}) -- Ir a la escena de menu.lua
            composer.removeScene("game") -- Eliminar la escena de juego actual
        end
    end

    backButton:addEventListener("touch", backButtonClick)
end

-- Mostrar la escena de victoria
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Código previo a mostrar la escena
    elseif phase == "did" then
        -- Código al mostrar la escena
    end
end

-- Ocultar la escena de victoria
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Código previo a ocultar la escena
    elseif phase == "did" then
        -- Código al ocultar la escena
    end
end

-- Destruir la escena de victoria
function scene:destroy(event)
    local sceneGroup = self.view

    -- Código al destruir la escena
end

-- Asignar los listeners de los eventos de la escena
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

-- Retornar la escena
return scene
