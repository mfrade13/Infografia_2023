local composer = require( "composer" )
 
local scene = composer.newScene()

local fondo 

 function irMenu(event)
    if event.phase == "ended" or event.phase == "cancelled" then
        print(" Cambiando al menu")
        composer.gotoScene("menu", "fade", 500)
    end
    return true
 end


local botonMenu
local textoMenu 

function tocar_botonMenu(event)
  if event.phase == "ended" then
    --self.isVisible = false

  end
  return true
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
 
    --for k,v in pairs(event.params) do
      --  print(k,v)
    --end
    --indice_del_fondo = event.params.fondo
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newImageRect(sceneGroup, rutaAssets.. "escaner.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
    --------------------------------
    botonMenu = display.newRoundedRect(CW/2-180, CH/2-50, 81, 33, 4 )
    botonMenu:setFillColor( 0,0,0 )
    textoMenu = display.newText( "MENU", botonMenu.x, botonMenu.y , "Comic Sans MS", 11 )
    botonMenu.isVisible = false
    textoMenu.isVisible = false

    protector = display.newImageRect( rutaAssets.. "protectorAmong.png", 40, 45 )
    protector.x, protector.y = CW/2, CH/2+2
    protector.alpha = 0.7


    --cuboProtector = display.newRoundedRect( CW/2, CH/2+2, 40, 40, 10 )
    --cuboProtector:setFillColor( 0,1,0,0.3 )

    --cubocirculo = display.newCircle(  CW/2, CH/2-5, 20 )
    --cubocirculo:setFillColor( 0,1,0,0.3 )


    -- local icono = display.newImageRect(sceneGroup, "Icon.png",CW/2, CH/2 )
    -- icono.x = CW/2; icono.y =CH/2
    --fondo:addEventListener("touch", irMenu)
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


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        botonMenu:addEventListener("touch", irMenu)

    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --fondo:removeEventListener("touch", fondo)
        botonMenu:removeEventListener("touch", tocar_botonMenu)
        botonMenu.isVisible=false
        textoMenu.isVisible=false
        
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
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