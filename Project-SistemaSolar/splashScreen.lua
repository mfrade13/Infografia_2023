local composer = require( "composer" )
local widget = require( "widget" )

local scene = composer.newScene()
 

local fondo

function irSistema()
    composer.gotoScene("sistema", "zoomInOutFade")
end

 function moveBigBang(e)
    if e.phase == "ended" then
        transition.to(fondo, { xScale=2.5, yScale=2.5, y = -CH/2, x = -CW/2, onComplete=irSistema})
    end
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    
    fondo_bienvenida = {
        type = "image",
        filename = "Assets/space2.jpg"
    }
    fondo = display.newRect( sceneGroup, 0, 0, CW, CH)
    fondo.x, fondo.y = 0,0
    fondo.anchorX = 0; fondo.anchorY = 0
    fondo.fill = fondo_bienvenida

    fondo:addEventListener("touch", moveBigBang)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        --timer.performWithDelay(1000, irSistema)
 
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