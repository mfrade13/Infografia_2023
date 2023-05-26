local composer = require("composer")
local scene = composer.newScene()

local json = require("json")
local imagenDigimon
local nombresDigimon = { "Agumon", "Koromon", "Frigimon", "Botamon", "Kiwimon", "Gomamon", "MarineAngemon", "Muchomon", "Vermilimon", "Goldramon", "Wormmon", "Hawkmon", "Armadillomon", "Greymon", "Garurumon", "Birdramon", "Kabuterimon", "Togemon", "Ikkakumon", "Angemon", "Angewomon", "ExVeemon", "Stingmon", "Kyubimon", "Antylamon", "Aquilamon", "Ankylomon" }
local indiceDigimon = 1
local siguiente
local anterior
local CW = display.contentWidth
local CH = display.contentHeight
local pathAssets = "imagenes/"
local fondoDigimon
local fondoDigimonDetalles1
local nombreDigimon
local fondoDigimonTexto1
local url
--------------------------------
local musica

musica= audio.loadStream(pathAssets.."Digimon.mp3")
audio.play(musica, { loops = -1 })

--volver
function irMenu(event)
    if event.phase == "ended" then
        composer.gotoScene("menu", "fade")
        
    end
    return true
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    fondoMenu = display.newImageRect(sceneGroup, pathAssets .. "fondoVentana2.png", CW, CH)
    fondoMenu.x, fondoMenu.y = CW / 2, CH / 2
     --boton regresar
     botonRegresar = display.newImageRect(sceneGroup, pathAssets .. "Boton_Regresar2.png", 160, 70)
     botonRegresar.x, botonRegresar.y = CW / 1.21, CH / 1.2
     --boton siguiente
     siguiente = display.newImageRect(sceneGroup, pathAssets .. "siguiente2.png", 50, 50)
     siguiente.x, siguiente.y = CW / 1.15, CH / 6.7
     --boton anterior
     anterior = display.newImageRect(sceneGroup, pathAssets .. "anterior2.png", 50, 50)
     anterior.x, anterior.y = CW / 1.4, CH / 6.7
     --fondo atras del pokemon
    fondoDigimon = display.newRect(sceneGroup, CW / 3.5, CH / 2, 1500 / 6, 1000 / 6)
    fondoDigimon:setFillColor(1,1,1)
    fondoDigimon.alpha = 0.4
    --fondo atras de la informacion del pokemon
    fondoDigimonTexto1 = display.newRect(sceneGroup, CW / 1.29, CH / 1.9, 195, 85 )
    fondoDigimonTexto1:setFillColor(1,1,1)
    fondoDigimonTexto1.alpha = 0.4
   --texto 2 del pokemon 
   fondoDigimonDetalles1 = display.newText(sceneGroup, "", CW / 1.24, CH / 1.9, 195, 0, "Comic Sans MS", 14)
   fondoDigimonDetalles1:setFillColor(0,0,0)
    ---
    nombreDigimon= display.newText(sceneGroup, "", CW / 3.5, CH / 1.55, "Times New Roman", 25)
    nombreDigimon:setFillColor(1, 1, 1)
    local function manejoRespuesta(event)

        if (event.isError) then
            print("Network error: ", event.response)
        else
            local datos = json.decode(event.response)
            if datos then
                nombreDigimon.text = datos[1].name

                if imagenDigimon then
                    display.remove(imagenDigimon)
                    imagenDigimon = nil
                end

                if datos[1].img then
                    display.loadRemoteImage(
                        datos[1].img,
                        "GET",
                        function(event)
                            if not event.isError then
                                imagenDigimon = event.target
                                imagenDigimon.x = CW / 3.5
                                imagenDigimon.y = CH / 3
                                imagenDigimon.width = 170
                                imagenDigimon.height = 170
                                sceneGroup:insert(imagenDigimon)
                            else
                                print("Error loading image:", event.response)
                            end
                        end,
                        "tempDigimon.png",
                        system.TemporaryDirectory
                    )
                else
                    print("No hay datos de imagen disponibles para los Digimon")
                end

                local detalles = "Nivel: " .. datos[1].level .. "\n"
                fondoDigimonDetalles1.text = detalles
            else
                print("No se recibieron datos de la solicitud de red")
            end
        end
    end
    function cargarDigimon()
        url = "https://digimon-api.vercel.app/api/digimon/name/" .. nombresDigimon[indiceDigimon]
        network.request(url, "GET", manejoRespuesta) 
    end
    siguiente:addEventListener("tap", function()
        indiceDigimon = indiceDigimon + 1
        if indiceDigimon > #nombresDigimon then
            indiceDigimon = 1
        end
        cargarDigimon()
    end)

    anterior:addEventListener("tap", function()
        indiceDigimon = indiceDigimon - 1
        if indiceDigimon < 1 then
            indiceDigimon = #nombresDigimon
        end
        cargarDigimon()
    end)

    cargarDigimon()


    ------------------------
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        
        audio.play(musica, { loops = -1 })
        botonRegresar:addEventListener("touch",irMenu)
        
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        botonRegresar:removeEventListener("touch", irMenu)  -- Utilizar la función irMenu en lugar de botonRegresar
        anterior:removeEventListener("touch", anterior)
        siguiente:removeEventListener("touch", siguiente)
        fondoDigimonDetalles1.text = ""
         display.remove(imagenDigimon)
        imagenDigimon = nil
        audio.stop()
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene