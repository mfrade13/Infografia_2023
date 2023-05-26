local composer = require("composer")
local scene = composer.newScene()

-- Función para crear la escena de niveles
function scene:create(event)
    local sceneGroup = self.view

    -- Crea el fondo de la pantalla de niveles
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight)
    background.fill = {type = "image", filename = "fondo.png"} -- Establece la imagen de fondo

    -- Función para manejar el evento de clic en los botones de nivel
    local function levelButtonClick(event)
        local target = event.target
        local level = target.level

        local dificultad = 0
        local tiempo = 0

        if level == 1 then
            dificultad = 4
            tiempo = 10
        elseif level == 2 then
            dificultad = 6
            tiempo = 180
        elseif level == 3 then
            dificultad = 10
            tiempo = 240
        end

        -- Llama a composer.gotoScene y pasa la dificultad como parámetro en la tabla options
        composer.gotoScene("game", {params = {dificultad = dificultad, tiempo = tiempo}})
    end

    -- Crear los botones de nivel
    local levelButtonY = display.contentHeight / 5

    for i = 1, 3 do
        local levelButton = display.newImageRect(sceneGroup, "nivel" .. i .. ".png", 230, 80)
        levelButton.x = display.contentCenterX
        levelButton.y = levelButtonY

        levelButton.level = i -- Asignar el número de nivel al botón
        levelButton:addEventListener("tap", levelButtonClick) -- Asignar el evento de clic al botón

        levelButtonY = levelButtonY + (display.contentHeight / 4)
    end

    -- Función para manejar el evento de clic en el botón "Volver"
    local function volverButtonClick(event)
        if event.phase == "ended" then
            composer.gotoScene("menu", { effect = "fade", time = 400 })
        end
    end

    -- Crear el botón "Volver"
    local volverButton = display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentHeight - 50, 200, 50, 10)
    volverButton:setFillColor(0, 181/255, 204/255)
    volverButton.strokeWidth = 2 -- Ancho del borde
    volverButton:setStrokeColor(0, 0, 0) -- Color del borde

    local volverButtonText = display.newText({
        parent = sceneGroup,
        text = "Volver",
        x = volverButton.x,
        y = volverButton.y,
        font = "Helvetica",
        fontSize = 23
    })
    volverButtonText:setFillColor(1, 1, 1) -- Establecer el color del texto del botón "Volver"

    -- Agregar sombra al botón "Volver"
    local shadow = display.newRoundedRect(sceneGroup, volverButton.x, volverButton.y, volverButton.width, volverButton.height, 10)
    shadow.fill = {0, 0, 0, 0.5} -- Color de la sombra
    shadow.x = volverButton.x + 2 -- Desplazamiento horizontal de la sombra
    shadow.y = volverButton.y + 2 -- Desplazamiento vertical de la sombra
    shadow.strokeWidth = 0 -- Sin borde
    shadow:toBack() -- Colocar la sombra detrás del botón

    -- Función para manejar los efectos de interacción del botón "Volver"
    local function volverButtonTouch(event)
        local phase = event.phase
        if phase == "began" then
            volverButton:setFillColor(177/255, 223/255, 40/255) -- Cambiar el color del botón al presionarlo
            shadow.alpha = 0.8 -- Cambiar la opacidad de la sombra al presionarlo
        elseif phase == "ended" or phase == "cancelled" then
            volverButton:setFillColor(0, 181/255, 204/255) -- Restaurar el color original del botón
            shadow.alpha = 0.5 -- Restaurar la opacidad original de la sombra
            if phase == "ended" then
                composer.gotoScene("menu", { effect = "fade", time = 400 }) -- Ir a la escena de menú
            end
        end
        return true
    end

    volverButton:addEventListener("touch", volverButtonTouch)
end

scene:addEventListener("create", scene)

return scene
