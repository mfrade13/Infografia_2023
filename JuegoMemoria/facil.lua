local composer = require("composer")
local scene = composer.newScene()

local filas = 2
local columnas = 2
local tiempoInicial = 0
local temporizador
local contadorTexto

local tarjetaAncho = 100
local tarjetaAlto = 150


local giradas = 0
local seleccionada = nil
local limite = false
pausado = false
local tabla ={}
local tiempo = 10
local ganador = false
local perdedor = false


local function actualizarTiempo()
    if not perdedor and not ganador then
        tiempoInicial = tiempoInicial + 1
        contadorTexto.text = "Tiempo: " .. tiempoInicial
    end
    if tiempo==tiempoInicial and not perdedor then
        
        local btnperdiste = display.newRoundedRect( display.contentCenterX, 150, 200, 50,10)
        btnperdiste:setFillColor(1, 0, 0) -- Rojo
        btnperdiste.strokeWidth = 2
        btnperdiste:setStrokeColor(0, 0, 0)
        txtperdiste = display.newText( "Perdiste", display.contentCenterX, btnperdiste.y , "Consolas", 24)
        txtperdiste:setFillColor(1, 1, 1) -- Blanco
        
        perdedor =true
        pausado=true
        
        timer.performWithDelay(3000, cambiar) 

    end

end
local function cambiar()
    composer.gotoScene("menu", { effect = "fade", time = 400 }) 
end

local function pausarTemporizador()
    if temporizador then
        timer.pause(temporizador)
    end
end

local function reanudarTemporizador()
    if temporizador then
        timer.resume(temporizador)
    end
end

local function mezclarArreglo(arr)
    local tamano = #arr
    for i = tamano, 2, -1 do
        local j = math.random(i)
        arr[i], arr[j] = arr[j], arr[i]
    end
end

local function onTouchboton(event)
    local button = event.target
    display.remove(button)
    display.remove(txtganador)
    --display.remove(txtperdiste)
    composer.gotoScene("menu", { effect = "fade", time = 400 }) 
end

local function onTouchTarjeta(event)
    local tarjeta = event.target
    
    if event.phase == "began" and not pausado and not limite and not tarjeta.isOpen  then
        tarjeta.isOpen = true
        tarjeta.fill = {type = "image", filename = rutaAssets.."card" .. tarjeta.contenido .. ".jpg"}

        if seleccionada == nil then
            seleccionada = tarjeta
        else
            limite = true --Ya se han seleccionado dos 
            if tarjeta.contenido == seleccionada.contenido then
                giradas = giradas + 2
                seleccionada = nil
                limite = false

                if giradas == filas * columnas then
                    ganador=true
                    
                    print("Haz ganado")  
                    local btnganador = display.newRoundedRect( display.contentCenterX, 150, 200, 50,10)
                    btnganador:setFillColor(0, 1, 0) -- Rojo
                    btnganador.strokeWidth = 2
                    btnganador:setStrokeColor(0, 0, 0)
                    txtganador = display.newText( "Ganaste", display.contentCenterX, btnganador.y , "Consolas", 24)
                    txtganador:setFillColor(1, 1, 1) -- Blanco
                    btnganador:addEventListener("touch", onTouchboton)

                end
            else
                timer.performWithDelay(1000, function()
                    tarjeta.isOpen = false
                    tarjeta.fill = {
                        type = "image",
                        filename = rutaAssets .. "back.jpg"
                    }
                    seleccionada.isOpen = false
                    seleccionada.fill = {
                        type = "image",
                        filename =rutaAssets .. "back.jpg"
                    }
                    seleccionada = nil
                    limite = false
                end)
            end
        end
    end

    return true
end

local function tarjetas(sceneGroup)

    local margenX = 50 
    local margenY = 50 

    local xDisponible = CW - 2 * margenX
    local yDisponible = CH - 2 * margenY

    local tarjetaTotalAncho = columnas * tarjetaAncho + (columnas - 1) * 6
    local tarjetaTotalAlto = filas * tarjetaAlto + (filas - 1) * 6

    local escala = 1 
    if tarjetaTotalAncho > xDisponible or tarjetaTotalAlto > yDisponible then
        local escalaX = xDisponible / tarjetaTotalAncho
        local escalaY = yDisponible / tarjetaTotalAlto
        escala = math.min(escalaX, escalaY)
    end

    local ocupadox = tarjetaTotalAncho * escala + (columnas - 1) * 6
    local ocupadoy = tarjetaTotalAlto * escala + (filas - 1) * 6

    local offsetX = (CW - ocupadox) / 2
    local offsetY = (CH - ocupadoy) / 2

    local mazo = {}

    for i = 1, 2 do
        table.insert(mazo, i, i)
    end
   

    for fila = 1, filas do
        tabla[fila] = {}
        mezclarArreglo(mazo)

        for columna = 1, columnas do
            local x = offsetX + (columna - 1) * (tarjetaAncho * escala + 6)
            local y = offsetY + (fila - 1) * (tarjetaAlto * escala + 6)

            local tarjeta = display.newRect(x, y, tarjetaAncho * escala, tarjetaAlto * escala)
            tarjeta.fill = {type = "image", filename = rutaAssets .. "back.jpg"}
            tarjeta.anchorX , tarjeta.anchorY = 0,0
            tarjeta.x,  tarjeta.y = x ,y

            contenido = mazo[columna]

            tabla[fila][columna] = contenido
            tarjeta.contenido = contenido
            tarjeta.isOpen = false

            tarjeta:addEventListener("touch", onTouchTarjeta)
            sceneGroup:insert(tarjeta)  
        end
    end
end

function scene:create(event)
    local sceneGroup = self.view
   
    background = display.newImageRect(sceneGroup, rutaAssets .. "nubes.jpg", display.contentWidth, display.contentHeight)
      background.x, background.y = display.contentCenterX, display.contentCenterY

    contadorTexto = display.newText({
        parent = sceneGroup,
        text = "Tiempo: " .. tiempoInicial,
        x = 50,
        y = 30,
        fontSize = 14,
    })
    contadorTexto:setTextColor(0, 0, 0)
    tarjetas(sceneGroup)

end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    local pausaButton = display.newImageRect(sceneGroup, rutaAssets .. "pausa.png",40, 40)
    pausaButton.x, pausaButton.y=290,30

    if phase == "will" then
        tiempoInicial = 0

        temporizador = timer.performWithDelay(1000, actualizarTiempo, 0)
        
    elseif phase == "did" then
        
        pausado = false
        local function togglePausa()
            if pausado then
                reanudarTemporizador()
                pausado = false  
            else
                pausarTemporizador()
                pausado = true
            end
        end
        pausaButton:addEventListener("tap", togglePausa)
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene