local composer = require("composer")
local scene = composer.newScene()

-- Variables
local tiempoInicial
local tiempoText
local timerID

-- Función para crear la escena del temporizador
function scene:create(event)
    local sceneGroup = self.view

    -- Obtener los parámetros pasados desde la escena anterior
    local params = event.params
    tiempoInicial = params.tiempo

    -- Crear el texto del temporizador
    tiempoText = display.newText({
        parent = sceneGroup,
        text = tostring(tiempoInicial),
        x = display.contentCenterX,
        y = display.contentCenterY,
        font = native.systemFont,
        fontSize = 40
    })
end

-- Función para actualizar el temporizador
local function actualizarTemporizador()
    tiempoInicial = tiempoInicial - 1
    tiempoText.text = tostring(tiempoInicial)

    if tiempoInicial <= 0 then
        -- El tiempo ha llegado a 0, detener el temporizador
        timer.cancel(timerID)

        -- Ir a la escena de resultado
        composer.gotoScene("resultado", {effect = "fade", time = 400})
    end
end

-- Función para manejar el evento de muestra de la escena
function scene:show(event)
    local phase = event.phase

    if phase == "did" then
        -- Iniciar el temporizador
        timerID = timer.performWithDelay(1000, actualizarTemporizador, tiempoInicial)
    end
end

-- Función para manejar el evento de ocultamiento de la escena
function scene:hide(event)
    local phase = event.phase

    if phase == "will" then
        -- Detener el temporizador si la escena se va a ocultar
        timer.cancel(timerID)
    end
end

-- Asignar los listeners de eventos a la escena
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)

return scene
