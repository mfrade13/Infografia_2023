local composer = require( "composer" )
 
local scene = composer.newScene()
local fondo

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
---------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
function irComic(event) 
    if event.phase == "ended" then
        composer.gotoScene("pagina1", {time = 1000, effect = "slideLeft"})
        print("cambio de escena")
    end
    return true
end

-- create()
function scene:create( event )
 
    local portada = {
        type = "image",
        filename = "batman_portada.jpg"
    }

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newRect(sceneGroup, 0,0,CW, CH)
    --fondo = display.newCircle(sceneGroup,0,0, CW/3)
    fondo.x, fondo.y = CW/2, CH/2
    fondo.fill = portada
    --fondo:setFillColor(1,0,0)
    --fondo.fill.r = 0
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        fondo:addEventListener("touch", irComic)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
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