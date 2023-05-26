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
    background:setFillColor(1, 1, 1) -- Color blanco

    -- Crear texto de victoria
    local victoryText = display.newText({
        parent = sceneGroup,
        text = "¡Has ganado!",
        x = display.contentCenterX,
        y = display.contentCenterY,
        font = native.systemFontBold,
        fontSize = 36
    })
    victoryText:setFillColor(0, 0, 0) -- Color negro
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
