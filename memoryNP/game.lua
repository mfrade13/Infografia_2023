local composer = require("composer")

local sceneName = "game"
local scene = composer.newScene(sceneName)

local dificultad
local numFilas
local numColumnas

local tarjetaAncho = 100
local tarjetaAlto = 150
local separacionX = 5
local separacionY = 5

local grid = {}
local tarjetasAbiertas = 0
local tarjetaSeleccionada = nil
local bloqueoInteraccion = false

local function mezclarArreglo(arr)
    local tamano = #arr
    for i = tamano, 2, -1 do
        local j = math.random(i)
        arr[i], arr[j] = arr[j], arr[i]
    end
end

local function onTouchTarjeta(event)
    local tarjeta = event.target

    print("Contenido: " .. tarjeta.contenido)

    if event.phase == "began" and not bloqueoInteraccion and not tarjeta.isOpen then
        tarjeta.isOpen = true
        tarjeta.fill = {type = "image", filename = tarjeta.contenido .. ".png"}

        if tarjetaSeleccionada == nil then
            tarjetaSeleccionada = tarjeta
        else
            bloqueoInteraccion = true

            if tarjeta.contenido == tarjetaSeleccionada.contenido then
                tarjetasAbiertas = tarjetasAbiertas + 2
                tarjetaSeleccionada = nil
                bloqueoInteraccion = false

                if tarjetasAbiertas == numFilas * numColumnas then
                    print("¡Has ganado!")
                    composer.
                    -- Aquí puedes mostrar una pantalla de victoria o reiniciar el juego
                    composer.gotoScene("resultado")
                end
            else
                timer.performWithDelay(1000, function()
                    tarjeta.isOpen = false
                    tarjeta.fill = {
                        type = "image",
                        filename = "tarjeta_cerrada.png"
                    }
                    tarjetaSeleccionada.isOpen = false
                    tarjetaSeleccionada.fill = {
                        type = "image",
                        filename = "tarjeta_cerrada.png"
                    }
                    tarjetaSeleccionada = nil
                    bloqueoInteraccion = false
                end)
            end
        end
    end

    return true
end

local function crearTarjetas()
    local anchoPantalla = display.actualContentWidth
    local altoPantalla = display.actualContentHeight

    local margenX = 50 -- Margen horizontal
    local margenY = 50 -- Margen vertical

    local espacioDisponibleX = anchoPantalla - 2 * margenX
    local espacioDisponibleY = altoPantalla - 2 * margenY

    local tarjetaTotalAncho = numColumnas * tarjetaAncho + (numColumnas - 1) * separacionX
    local tarjetaTotalAlto = numFilas * tarjetaAlto + (numFilas - 1) * separacionY

    local escala = 1 -- Factor de escala para ajustar las tarjetas si exceden el espacio disponible
    if tarjetaTotalAncho > espacioDisponibleX or tarjetaTotalAlto > espacioDisponibleY then
        local escalaX = espacioDisponibleX / tarjetaTotalAncho
        local escalaY = espacioDisponibleY / tarjetaTotalAlto
        escala = math.min(escalaX, escalaY)
    end

    local espacioOcupadoX = tarjetaTotalAncho * escala + (numColumnas - 1) * separacionX
    local espacioOcupadoY = tarjetaTotalAlto * escala + (numFilas - 1) * separacionY

    local offsetX = (anchoPantalla - espacioOcupadoX) / 2
    local offsetY = (altoPantalla - espacioOcupadoY) / 2

    local arreglo1 = {}

    for i = 1, dificultad do
        table.insert(arreglo1, i, math.random(1, dificultad))
    end

    for fila = 1, numFilas do
        grid[fila] = {}
        mezclarArreglo(arreglo1)

        for columna = 1, numColumnas do
            local x = offsetX + (columna - 1) * (tarjetaAncho * escala + separacionX)
            local y = offsetY + (fila - 1) * (tarjetaAlto * escala + separacionY)

            local tarjeta = display.newRect(x, y, tarjetaAncho * escala, tarjetaAlto * escala)
            tarjeta.fill = {type = "image", filename = "tarjeta_cerrada.png"}
            tarjeta.anchorX = 0
            tarjeta.anchorY = 0
            tarjeta.x = x
            tarjeta.y = y

            local contenido = arreglo1[columna]

            grid[fila][columna] = contenido
            tarjeta.contenido = contenido
            tarjeta.isOpen = false

            tarjeta:addEventListener("touch", onTouchTarjeta)
        end
    end
end


function scene:create(event)
    local sceneGroup = self.view

    -- Obtén el parámetro "dificultad" de event.params
    dificultad = event.params.dificultad
    numFilas = dificultad
    numColumnas = dificultad

    -- Crea las tarjetas con la dificultad especificada
    crearTarjetas()

    -- Aquí puedes agregar el código para crear y mostrar los elementos visuales de tu juego

end

-- Puedes agregar más funciones y eventos según tus necesidades

scene:addEventListener("create", scene)

return scene
