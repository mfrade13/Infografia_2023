local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local fondo
--local copa
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
--





--local tablaFondos = {1,5,8,9}

--local options = {
  --  effect = "slideUp",
    --time = 500,
    --params = {
      --  nivel = 2,
        --fondo =  tablaFondos[math.random(1,4)]
    --}
--}
--
function irMeteoros(event)
    if event.phase == "ended" then
        composer.gotoScene("meteoros", "fade")
    end
    return true
end

function irCables(event)
    if event.phase == "ended" then
        composer.gotoScene("cables", "fade")
    end
    return true
end

function irEScaner(event)
    if event.phase == "ended" then
        composer.gotoScene("escaner", "fade")
    end
    return true
end

function irGasolina(event)
    if event.phase == "ended" then
        composer.gotoScene("gasolina", "fade")
    end
    return true
end

---------------------------------
local optMeteoros
local textoMeteoros
local optCables
local textoCables
local optEscaner
local textoEscaner
local optGasolina
local textoGasolina

function eventMeteoro(event)
  if event.phase == "ended" then
    --self.isVisible = false

  end
  return true
end

function eventCables(event)
  if event.phase == "ended" then
    --self.isVisible = false

  end
  return true
end

function eventEscaner(event)
  if event.phase == "ended" then
    --self.isVisible = false

  end
  return true
end

function eventGasolina(event)
  if event.phase == "ended" then
    --self.isVisible = false

  end
  return true
end

--------------------------------

--function botonesMenu()
--utilizar como la funcion de arriba irGasolina
--colocar este en global
--[[
    local optMeteoros = display.newRoundedRect(CW/2-48, CH/2+50, 81, 33, 4 )
    optMeteoros:setFillColor( 0,0,0 )
    local textoMeteoros = display.newText( "METEORITOS", optMeteoros.x, optMeteoros.y , "Comic Sans MS", 10 )

    local optCables = display.newRoundedRect(CW/2-46, CH/2+92, 81, 20, 4 )
    optCables:setFillColor( 0,0,0 )
    local textoCables = display.newText( "CABLES", optCables.x, optCables.y , "Comic Sans MS", 10 )

    local optEscaner = display.newRoundedRect(CW/2+46, CH/2+50, 81, 33, 4 )
    optEscaner:setFillColor( 0,0,0 )
    local textoEscaner = display.newText( "ESCANER", optEscaner.x, optEscaner.y , "Comic Sans MS", 10 )

    local optGasolina = display.newRoundedRect(CW/2+46, CH/2+92, 81, 20, 4 )
    optGasolina:setFillColor( 0,0,0 )
    local textoGasolina = display.newText( "GASOLINA", optGasolina.x, optGasolina.y , "Comic Sans MS", 10 )

--end
--utilizar como la funcion de arriba irGasolina

function optMeteoros:touch(e)
  if e.phase == "ended" then
    self.isVisible = false

  end
  return true
end

function optCables:touch(e)
  if e.phase == "ended" then
    self.isVisible = false

  end
  return true
end

function optEscaner:touch(e)
  if e.phase == "ended" then
    self.isVisible = false

  end
  return true
end

function optGasolina:touch(e)
  if e.phase == "ended" then
    self.isVisible = false

  end
  return true
end
]]

-- create()
function scene:create( event )
    
 --crear aqui los datos sin local
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newImageRect(sceneGroup, rutaAssets.."menu.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
    --------------------------------------
    optMeteoros = display.newRoundedRect(CW/2-48, CH/2+50, 81, 33, 4 )
    optMeteoros:setFillColor( 0,0,0 )
    textoMeteoros = display.newText( "METEORITOS", optMeteoros.x, optMeteoros.y , "Comic Sans MS", 10 )
    optMeteoros.isVisible = false
    textoMeteoros.isVisible = false

    optCables = display.newRoundedRect(CW/2-46, CH/2+92, 81, 20, 4 )
    optCables:setFillColor( 0,0,0 )
    textoCables = display.newText( "CABLES", optCables.x, optCables.y , "Comic Sans MS", 10 )
    optCables.isVisible = false
    textoCables.isVisible = false

    optEscaner = display.newRoundedRect(CW/2+46, CH/2+50, 81, 33, 4 )
    optEscaner:setFillColor( 0,0,0 )
    textoEscaner = display.newText( "ESCANER", optEscaner.x, optEscaner.y , "Comic Sans MS", 10 )
    optEscaner.isVisible = false
    textoEscaner.isVisible = false

    optGasolina = display.newRoundedRect(CW/2+46, CH/2+92, 81, 20, 4 )
    optGasolina:setFillColor( 0,0,0 )
    textoGasolina = display.newText( "GASOLINA", optGasolina.x, optGasolina.y , "Comic Sans MS", 10 )
    optGasolina.isVisible = false
    textoGasolina.isVisible = false
    -----------------------------------------


    --botonesMenu()
    --[[
    local optMeteoros = display.newRoundedRect(CW/2-48, CH/2+50, 81, 33, 4 )
    optMeteoros:setFillColor( 0,0,0 )
    local textoMeteoros = display.newText( "METEORITOS", optMeteoros.x, optMeteoros.y , "Comic Sans MS", 10 )
]]

    --copa = display.newImageRect(sceneGroup, rutaAssets.."Oro.png", 100, 100)
    --copa.x, copa.y = math.random(0, CW), math.random(0,CH)

end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    print("Ejecucion del show")
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        print("Dentro del will de la funcion show")

        


        optMeteoros:addEventListener("touch", eventMeteoro)
        optCables:addEventListener("touch", eventCables)
        optEscaner:addEventListener("touch", eventEscaner)
        optGasolina:addEventListener("touch", eventGasolina)

        optMeteoros.isVisible = true
        textoMeteoros.isVisible = true

        optCables.isVisible = true
        textoCables.isVisible = true

        optEscaner.isVisible = true
        textoEscaner.isVisible = true

        optGasolina.isVisible = true
        textoGasolina.isVisible = true
        


        --botonesMenu()

                --function botonesMenu()
--[[
            local optMeteoros = display.newRoundedRect(CW/2-48, CH/2+50, 81, 33, 4 )
            optMeteoros:setFillColor( 0,0,0 )
            local textoMeteoros = display.newText( "METEORITOS", optMeteoros.x, optMeteoros.y , "Comic Sans MS", 10 )

            local optCables = display.newRoundedRect(CW/2-46, CH/2+92, 81, 20, 4 )
            optCables:setFillColor( 0,0,0 )
            local textoCables = display.newText( "CABLES", optCables.x, optCables.y , "Comic Sans MS", 10 )

            local optEscaner = display.newRoundedRect(CW/2+46, CH/2+50, 81, 33, 4 )
            optEscaner:setFillColor( 0,0,0 )
            local textoEscaner = display.newText( "ESCANER", optEscaner.x, optEscaner.y , "Comic Sans MS", 10 )

            local optGasolina = display.newRoundedRect(CW/2+46, CH/2+92, 81, 20, 4 )
            optGasolina:setFillColor( 0,0,0 )
            local textoGasolina = display.newText( "GASOLINA", optGasolina.x, optGasolina.y , "Comic Sans MS", 10 )

        --end

        function optMeteoros:touch(e)
          if e.phase == "ended" then
            self.isVisible = false

          end
          return true
        end

        function optCables:touch(e)
          if e.phase == "ended" then
            self.isVisible = false

          end
          return true
        end

        function optEscaner:touch(e)
          if e.phase == "ended" then
            self.isVisible = false

          end
          return true
        end

        function optGasolina:touch(e)
          if e.phase == "ended" then
            self.isVisible = false

          end
          return true
        end
]]

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("Dentro del did de la funcion show")
        --botonPlay:addEventListener("touch")

        optMeteoros:addEventListener("touch", irMeteoros)
        optCables:addEventListener("touch", irCables)
        optEscaner:addEventListener("touch", irEScaner)
        optGasolina:addEventListener("touch", irGasolina)


        --fondo:addEventListener("touch", irJuego)
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --fondo:removeEventListener("touch", fondo)
        optMeteoros:removeEventListener("touch", eventMeteoro)
        optCables:removeEventListener("touch", eventCables)
        optEscaner:removeEventListener("touch", eventEscaner)
        optGasolina:removeEventListener("touch", eventGasolina)

        optMeteoros.isVisible=false
        textoMeteoros.isVisible=false

        optCables.isVisible=false
        textoCables.isVisible=false

        optEscaner.isVisible=false
        textoEscaner.isVisible=false

        optGasolina.isVisible=false
        textoGasolina.isVisible=false

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
