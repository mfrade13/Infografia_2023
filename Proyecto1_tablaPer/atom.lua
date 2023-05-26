-- atom.lua

local composer = require("composer")
local scene = composer.newScene()

local physics = require("physics")
physics.start()


function scene:create(event)
    local sceneGroup = self.view

    for k, v in pairs (event.params) do
        print (k, v)
    end
    -- Obtener los parámetros
    local params = event.params.elemento
    --element = param.element
    
    local name = params.name
    local protons = params.atomicNumber
    local neutrons = params.neutrons
    local electrons = params.electrons
    local orbitals = params.orbitals

    -- fondo
    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0, 0, 0)

    -- núcleo 
    local nucleo = display.newCircle(sceneGroup, display.contentCenterX, display.contentCenterY, 5)
    nucleo:setFillColor(1, 0, 0)

    -- protones
    local radioProtones = 5 -- Radio de los círculos de los protones
    
    for i = 1, protons-1 do
        local angulo = (2 * math.pi / protons) * (i - 1)

        local x = display.contentCenterX + 15 * math.cos(angulo) -- Ajustar la posición de los protones dentro del núcleo
        local y = display.contentCenterY + 15 * math.sin(angulo) -- Ajustar la posición de los protones dentro del núcleo

        local proton = display.newCircle(sceneGroup, x, y, radioProtones)
        proton:setFillColor(1, 0, 0)
    end

    -- Crear los neutrones en el núcleo
    local radioNeutrones =5 -- Radio de los círculos de los protones

    for i = 1, neutrons-1 do
        local angulo = (2 * math.pi / neutrons) * (i - 1)

        local x = display.contentCenterX + 10 * math.cos(angulo) -- Ajustar la posición de los protones dentro del núcleo
        local y = display.contentCenterY + 10 * math.sin(angulo) -- Ajustar la posición de los protones dentro del núcleo

        local neutron = display.newCircle(sceneGroup, x, y, radioNeutrones)
        neutron:setFillColor(0, 0, 1)
    end

   --electrones y orbitas
    local radioBase = 50
    local distanciaEntreOrbitas = 20
    local electronIndex = 1
    local electronTable = {} -- Tabla para almacenar las referencias a los electrones

    for i, orbital in ipairs(orbitals) do
        local radio = radioBase + (i - 1) * distanciaEntreOrbitas -- Calcular el radio de la órbita actual
        local anguloInicial = math.random() * 360 -- Ángulo inicial aleatorio para la órbita
    
        local orbita = display.newCircle(sceneGroup, display.contentCenterX, display.contentCenterY, radio)
        orbita:setFillColor(0, 0, 0, 0)
        orbita.strokeWidth = 1
        orbita:setStrokeColor(1, 1, 1, 0.2)
    
        -- Rotar la órbita
        orbita.rotation = anguloInicial
    end

    local function animateElectrons(event)
        -- Eliminar los electrones anteriores
        for i = 1, #electronTable do
            display.remove(electronTable[i])
            electronTable[i] = nil
        end

        for i, orbital in ipairs(orbitals) do
            local radio = radioBase + (i - 1) * distanciaEntreOrbitas -- Calcular el radio de la órbita actual
            local anguloInicial = math.random() * 360 -- Ángulo inicial aleatorio para la órbita

            for j = 1, orbital do
                local angulo = (2 * math.pi / orbital) * (j - 1) + math.rad(anguloInicial)

                local x = display.contentCenterX + radio * math.cos(angulo)
                local y = display.contentCenterY + radio * math.sin(angulo)

                local electron = display.newCircle(sceneGroup, x, y, 5)
                electron:setFillColor(0, 1, 0)

                -- Calcular la posición final del electrón en la órbita
                local anguloFinal = angulo + math.pi * 2
                local xFinal = display.contentCenterX + radio * math.cos(anguloFinal)
                local yFinal = display.contentCenterY + radio * math.sin(anguloFinal)

                -- Animar el electrón hacia su posición final
                transition.to(electron, {
                    x = xFinal,
                    y = yFinal,
                    time = 2000000,
                    iterations = 0,
                })

                electronTable[#electronTable + 1] = electron -- Agregar el electrón a la tabla
            end
        end
    end

    Runtime:addEventListener("enterFrame", animateElectrons)

    -- Crear texto para mostrar el name del átomo
    local nameText = display.newText(sceneGroup, name, display.contentCenterX, display.contentHeight - 50, native.systemFontBold, 24)
    nameText:setFillColor(1, 1, 1)

    -- Opcional: Agregar un botón para volver a la escena anterior
    local backButton = display.newText(sceneGroup, "Volver", display.contentCenterX, display.contentHeight - 20, native.systemFontBold, 18)
    backButton:setFillColor(1, 1, 1)

    local function goBack()
        local options = {
            effect = "zoomInOut",
            time = 500,
        }
        composer.gotoScene("tabla", options)
    end

    backButton:addEventListener("tap", goBack)
end


function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    print("Ejecucion del show")
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        print("Dentro del will de la funcion show")

    elseif ( phase == "did" ) then
        composer.removeScene("tabla")
        -- Code here runs when the scene is entirely on screen
        print("Dentro del did de la funcion show")
        
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --fondo:removeEventListener("touch", fondo)
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
