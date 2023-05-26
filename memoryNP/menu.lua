local composer = require("composer")
local scene = composer.newScene()

-- Función para crear la escena del menú
function scene:create(event)
    local sceneGroup = self.view

    -- Aquí puedes agregar el código para crear los elementos visuales del menú
    display.setDefault("background", 1, 1, 1) -- Establecer el color de fondo en blanco

    local title = display.newText({
        parent = sceneGroup,
        text = "Título del Juego",
        x = display.contentCenterX,
        y = display.contentHeight * 0.3,
        font = native.systemFontBold,
        fontSize = 24
    })
    title:setFillColor(0, 0, 0) -- Establecer el color del título

    -- Función para manejar el evento de clic en el botón de niveles
    local function levelsButtonClick(event)
        if event.phase == "ended" then
            composer.gotoScene("niveles", { effect = "fade", time = 400 })
        end
    end

    -- Crear el botón de niveles
    local levelsButton = display.newRect(sceneGroup, display.contentCenterX, display.contentHeight * 0.5, 200, 50)
    levelsButton:setFillColor(0.5, 0.5, 0.5)

    local levelsButtonText = display.newText({
        parent = sceneGroup,
        text = "Escoger Niveles",
        x = levelsButton.x,
        y = levelsButton.y,
        font = native.systemFont,
        fontSize = 18
    })
    levelsButtonText:setFillColor(1, 1, 1) -- Establecer el color del texto del botón de niveles

    levelsButton:addEventListener("touch", levelsButtonClick)
end

scene:addEventListener("create", scene)

return scene
