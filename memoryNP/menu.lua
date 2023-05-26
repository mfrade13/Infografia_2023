local composer = require("composer")
local scene = composer.newScene()

-- Función para crear la escena del menú
function scene:create(event)
    local sceneGroup = self.view

    -- Aquí puedes agregar el código para crear los elementos visuales del menú
    local background = display.newImageRect(sceneGroup, "fondo.png", display.contentWidth, display.contentHeight)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local title = display.newImageRect(sceneGroup, "titulo.png", 570, 200)
    title.x = display.contentCenterX
    title.y = display.contentHeight * 0.3


    -- Crear el botón de niveles
    -- Crear el botón de niveles
    local levelsButton = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentHeight * 0.65, 200, 50, 10)
    levelsButton:setFillColor(0,181/255,204/255)
    levelsButton.strokeWidth = 2 -- Ancho del borde
    levelsButton:setStrokeColor(0, 0, 0) -- Color del borde

    local levelsButtonText = display.newText({
        parent = sceneGroup,
        text = "Comenzar",
        x = levelsButton.x,
        y = levelsButton.y,
        font = "Helvetica", -- Cambia la tipografía aquí
        fontSize = 23
    })
    levelsButtonText:setFillColor(1, 1, 1) -- Establecer el color del texto del botón de niveles

    -- Agregar sombra al botón
    local shadow = display.newRoundedRect(sceneGroup, levelsButton.x, levelsButton.y, levelsButton.width, levelsButton.height, 10)
    shadow.fill = {0, 0, 0, 0.5} -- Color de la sombra
    shadow.x = levelsButton.x + 2 -- Desplazamiento horizontal de la sombra
    shadow.y = levelsButton.y + 2 -- Desplazamiento vertical de la sombra
    shadow.strokeWidth = 0 -- Sin borde
    shadow:toBack() -- Colocar la sombra detrás del botón

    -- Función para manejar los efectos de interacción del botón
    local function levelsButtonTouch(event)
        local phase = event.phase
        if phase == "began" then
            levelsButton:setFillColor(177/255, 223/255, 40/255) -- Cambiar el color del botón al presionarlo
            shadow.alpha = 0.8 -- Cambiar la opacidad de la sombra al presionarlo
        elseif phase == "ended" or phase == "cancelled" then
            levelsButton:setFillColor(0,181/255,204/255) -- Restaurar el color original del botón
            shadow.alpha = 0.5 -- Restaurar la opacidad original de la sombra
            if phase == "ended" then
                composer.gotoScene("niveles", { effect = "fade", time = 400 }) -- Ir a la escena de niveles
            end
        end
        return true
    end

    levelsButton:addEventListener("touch", levelsButtonTouch)

end

scene:addEventListener("create", scene)

return scene
