local composer = require("composer")
local scene = composer.newScene()

-- Definir las funciones de manejo de eventos para cada botón
  function onDificilPressed(event)
    if event.phase == "ended" then
      composer.gotoScene("dificil", { effect = "fade", time = 400 }) 
    end
  end
  
  function onMedioPressed(event)
    if event.phase == "ended" then
      composer.gotoScene("medio", { effect = "fade", time = 400 }) 
    end
  end
  
  function onFacilPressed(event)
    if event.phase == "ended" then
      composer.gotoScene("facil", { effect = "fade", time = 400 }) 
    end
  end
  
  function scene:create( event )
      local sceneGroup = self.view
      local background = display.newImageRect(sceneGroup, rutaAssets.."menuf.jpg", display.contentWidth, display.contentHeight)
      background.x = display.contentCenterX
      background.y = display.contentCenterY

      -- Crear el botón Fácil
      local btnFacil = display.newRoundedRect(sceneGroup, display.contentCenterX, 150, 200, 50,10)
      btnFacil:setFillColor(0, 1, 0) -- Verde
      btnFacil.strokeWidth = 2
      btnFacil:setStrokeColor(0, 0, 0)
      local txtFacil = display.newText(sceneGroup, "Facil", display.contentCenterX, btnFacil.y , "Consolas", 24)
      txtFacil:setFillColor(1, 1, 1) -- Blanco
      btnFacil:addEventListener("touch", onFacilPressed)
  
      -- Crear el botón Medio
      local btnMedio = display.newRoundedRect(sceneGroup, display.contentCenterX, 250, 200, 50,10)
      btnMedio:setFillColor(1, 1, 0) -- Amarillo
      btnMedio.strokeWidth = 2
      btnMedio:setStrokeColor(0, 0, 0)
      local txtMedio = display.newText(sceneGroup, "Medio", display.contentCenterX, btnMedio.y,"Consolas", 24)
      txtMedio:setFillColor(0, 0, 0) -- Negro
      btnMedio:addEventListener("touch", onMedioPressed)
  
      -- Crear el botón Dificil
      local btnDificil = display.newRoundedRect(sceneGroup, display.contentCenterX, 350, 200, 50,10)
      btnDificil:setFillColor(1, 0, 0) -- Rojo
      btnDificil.strokeWidth = 2
      btnDificil:setStrokeColor(0, 0, 0)
      local txtDificil = display.newText(sceneGroup, "Dificil", display.contentCenterX, btnDificil.y , "Consolas", 24)
      txtDificil:setFillColor(1, 1, 1) -- Blanco
      btnDificil:addEventListener("touch", onDificilPressed)
  end

  --function scene:show( event )
    --local sceneGroup = self.view
  
 -- end
    function scene:hide( event )
      local sceneGroup = self.view
      local phase = event.phase
 
      if ( phase == "will" ) then
        
      elseif ( phase == "did" ) then
        
      end
   end

  -- Asignar la función scene:create() al evento "create" de la escena
  scene:addEventListener("create", scene )
  --scene:addEventListener( "show", scene )
  scene:addEventListener( "hide", scene )
  --scene:addEventListener( "destroy", scene )
  
  -- Retornar la escena
  return scene