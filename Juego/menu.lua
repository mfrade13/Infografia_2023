local composer = require( "composer" )
 
local scene = composer.newScene()
 ------------------------------------------------------
local CW = display.contentWidth
local CH = display.contentHeight
local pathAssets = "imagenes/"
------------------------------------
--botones 
local opcion1 
local opcion2
------------------------------------------------------
function irAVentana1(event)
    if event.phase == "ended" then
        composer.gotoScene("ventana1", "fade")
    end
    return true
end
function irAVentana2(event)
    if event.phase == "ended" then
        composer.gotoScene("ventana2", "fade")
    end
    return true
end
function scene:create( event )
 
    local sceneGroup = self.view
    -- Código de inicialización aquí
    local fondoMenu = display.newImageRect(sceneGroup,pathAssets.."fondoInicio.jpg",CW,CH)
    fondoMenu.x,fondoMenu.y = CW/2, CH/2

    --opcion 1
    opcion1 = display.newImageRect(pathAssets.."opcion1.png",100,20)
    opcion1.x, opcion1.y = CW/4.6,CH/1.04
    sceneGroup:insert(opcion1)

    --Opcion2
    opcion2 = display.newImageRect(pathAssets.."opcion2.png",100,20)
    opcion2.x, opcion2.y = CW/1.35,CH/1.04
    sceneGroup:insert(opcion2)
    
    
 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        
       print("Dentro del will de la funcion show")
    elseif ( phase == "did" ) then
        print("Dentro del did de la funcion show")
        opcion1:addEventListener("touch",irAVentana1)
        opcion2:addEventListener("touch",irAVentana2)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        opcion1:removeEventListener("touch", opcion1)
        opcion2:removeEventListener("touch", opcion2)
 
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