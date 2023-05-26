local composer = require("composer")
local scene = composer.newScene()

-- Función para crear la escena de niveles
function scene:create(event)
    local sceneGroup = self.view

    -- Aquí puedes agregar el código para crear los elementos visuales de la escena de niveles
    display.setDefault("background", 1, 1, 1) -- Establecer el color de fondo en blanco

    -- Función para manejar el evento de clic en los botones de nivel
    local function levelButtonClick(event)
        local target = event.target
        local level = target.level

        local dificultad = 0

        if level == 1 then
            dificultad = 6
        elseif level == 2 then
            dificultad = 8
        elseif level == 3 then
            dificultad = 9
        end

        -- Llama a composer.gotoScene y pasa la dificultad como parámetro en la tabla options
        composer.gotoScene("game", {params = {dificultad = dificultad}})
    end

    -- Crear los botones de nivel
    local levelButtonY = display.contentHeight / 4

    for i = 1, 3 do
        local levelButton = display.newText({
            parent = sceneGroup,
            text = "Nivel " .. i,
            x = display.contentCenterX,
            y = levelButtonY,
            width = 200,
            height = 50,
            font = native.systemFont,
            fontSize = 20
        })
        levelButton:setFillColor(0.5, 0.5, 0.5)

        levelButton.level = i -- Asignar el número de nivel al botón
        levelButton:addEventListener("tap", levelButtonClick) -- Asignar el evento de clic al botón

        levelButtonY = levelButtonY + (display.contentHeight / 4)
    end

    -- Función para manejar el evento de clic en el botón "Volver"
    local function backButtonClick(event)
        if event.phase == "ended" then
            composer.gotoScene("menu", { effect = "fade", time = 400 })
        end
    end

    -- Crear el botón "Volver"
    local backButton = display.newRect(sceneGroup, display.contentCenterX, display.contentHeight - 50, 100, 40)
    backButton:setFillColor(0.5, 0.5, 0.5)

    local backButtonText = display.newText({
        parent = sceneGroup,
        text = "Volver",
        x = backButton.x,
        y = backButton.y,
        font = native.systemFont,
        fontSize = 16
    })
    backButtonText:setFillColor(1, 1, 1) -- Establecer el color del texto del botón "Volver"

    backButton:addEventListener("touch", backButtonClick)
end

scene:addEventListener("create", scene)

return scene
