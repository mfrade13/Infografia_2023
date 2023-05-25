local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local fondo
local logo
local button
local texto
local selectSound
local audOpt

function irJuego(event)
    if event.phase == "ended" then
        audio.play(selectSound,audOpt);
        composer.gotoScene("juego", options)
    end
    return true
end


function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newImageRect(sceneGroup, ASSETS.."fondo.png",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2

    logo = display.newImageRect(sceneGroup, ASSETS.."logo.png",CW/1.5, CH/3 )
    logo.x = CW/2; logo.y =CH/3

    button = display.newImageRect(sceneGroup, ASSETS.."boton.png", CW/1.5, CH/10 )
    button.x = CW/2; button.y = 2*CH/3

    local textopt = {
        parent = sceneGroup,
        text = "START",
        x = button.x,
        y = button.y,
        width = CW/2.5,
        font = "MegamaxJones-elRm.ttf",
        fontSize = 24
    }
    texto = display.newText(textopt)

    selectSound = audio.loadSound(ASSETS.."select.wav")
    audOpt = {
        loops = 0,
        duration = audio.getDuration(selectSound),
    }
    button:addEventListener("touch", irJuego)
    texto:addEventListener("touch", irJuego)

end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    print("Ejecucion del show")
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        print("Dentro del will de la funcion show")

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("Dentro del did de la funcion show")
        --fondo:addEventListener("touch", irJuego)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        -- fondo:removeEventListener("touch", fondo)
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