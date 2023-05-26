local composer = require( "composer" )
local scene = composer.newScene()
local fondo
local grupoGrilla
-- cuadricula poder ubicarnos mejor en la pantalla para referenciar cuadros
-- trancisiones
-- eventos para trancisionar
local altura = CH/3
local ancho = CW/9 

function moveComic(e)
    if e.phase == "ended" then
        transition.to(fondo, {time = 1000, xScale=1, yScale=3, y = CH*1.5, onComplete= moverImagen })
    end
end

function scene:create( event )
 
    local sceneGroup = self.view
    grupoGrilla = display.newGroup()

    fondo = display.newImageRect(sceneGroup, "batman3.jpg", CW, CH)
    fondo.x, fondo.y = CW/2, CH/2

    for i=1, 3 do
        local line = display.newLine(grupoGrilla, 0, altura*i, CW, altura*i)
        line.strokeWidth = 3
        line:setStrokeColor(0)
    end

    for i=1,9 do
        local line = display.newLine(grupoGrilla, ancho*i, 0, ancho*i, CH)
        line.strokeWidth = 3
        line:setStrokeColor(0)
    end

    function moveImage3()
        transition.to(fondo, {x= CW/2, time =1000, delay=1000 })
    end

    function moverImagen()
        transition.to(fondo, {x= CW/2 + (ancho*9), y=CH/2, xScale=3, time = 1000, onComplete=moveImage3 })
    end

    fondo:addEventListener("touch", moveComic)

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
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