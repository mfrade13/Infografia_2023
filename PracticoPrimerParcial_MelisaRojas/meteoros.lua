local composer = require( "composer" )
 
local scene = composer.newScene()

local fondo 

local botonMenu
local textoMenu 

function irMenu(event)
    if event.phase == "ended" or event.phase == "cancelled" then
        print(" Cambiando al menu")
        composer.gotoScene("menu", "fade", 500)
    end
    return true
end


local obstaculos = {}

--para hacer aparecer los obstaculos
function eventoObstaculos(event)
    if event.phase == "ended" then
            --display.remove( obstaculos[i] )
    end
  
    return true
end

--para hacer desaparecer el obstaculo
function tocar_obstaculos(event)
    for i=30,1,-1 do
        if event.phase == "began" then
            display.remove( obstaculos[i] )
        end
        return true
    end

end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function tocar_botonMenu(event)
  if event.phase == "ended" then
    --self.isVisible = false

  end
  return true
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newImageRect(sceneGroup, rutaAssets.. "meteoros.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
    ------------------------------------
    botonMenu = display.newRoundedRect(CW/2-48, CH/2-50, 81, 33, 4 )
    botonMenu:setFillColor( 0,0,0 )
    textoMenu = display.newText( "MENU", botonMenu.x, botonMenu.y , "Comic Sans MS", 10 )
    botonMenu.isVisible = false
    textoMenu.isVisible = false

    for i=30,1,-1 do
            obstaculos[i] = display.newImageRect(rutaAssets.. "meteoro1.png", 72/3, 50/3 )
            obstaculos[i].x, obstaculos[i].y = math.random(10, CW), math.random(30, CH)
            obstaculos[i].isVisible = false
            transition.to(obstaculos[i], {time = 10500, x = 0})
            
    end

end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        composer.removeScene("menu")

        botonMenu:addEventListener("touch", tocar_botonMenu)
        botonMenu.isVisible = true
        textoMenu.isVisible = true


        for i=#obstaculos,1,-1 do
            --obstaculos[i]:addEventListener("touch", eventoObstaculos)
            --obstaculos[i].isVisible = true
        end


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        botonMenu:addEventListener("touch", irMenu)

        for i=#obstaculos,1,-1 do
            
            obstaculos[i]:addEventListener("touch", eventoObstaculos)
            obstaculos[i].isVisible = true
            
        end

        for i=#obstaculos,1,-1 do
            
            obstaculos[i]:addEventListener("touch", tocar_obstaculos)
            obstaculos[i].isVisible = true
            
        end

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        botonMenu:removeEventListener("touch", tocar_botonMenu)
        botonMenu.isVisible=false
        textoMenu.isVisible=false

        for i=#obstaculos,1,-1 do
            --obstaculos[i]:removeEventListener( "touch", tocar_obstaculos )
            --obstaculos[i]:removeEventListener("touch", eventoObstaculos)
            obstaculos[i].isVisible = false
        end
        
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        for i=30,1,-1 do
            --obstaculos[i]:removeEventListener( "touch", tocar_obstaculos )
            --obstaculos[i]:removeEventListener("touch", eventoObstaculos)
            --obstaculos[i].isVisible = false
        end
        --botonMenu:removeEventListener("touch", irMenu)
        --botonMenu.isVisible=false
        --textoMenu.isVisible=false

 
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