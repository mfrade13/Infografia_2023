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
    print("funciono menu")
    print(event.x, event.y)
    --self.isVisible = false

  end
  return true
end

--local cableRosado
--local cableRojo
--[[
function tocar_cableRosado(event)

    if event.phase == "began" then
        cableRosado = display.newLine( CW/2-100, CH/2-80, CW/2-80, CH/2-80 )
        cableRosado:setStrokeColor( 1, 0, 1 )
        cableRosado.strokeWidth = 5

        cableRosado.isVisible = true
    elseif event.phase == "moved" then
        if event.x == CW/2-100 and event.y == CH/2-80 then
            cableRosado:append( event.x, event.y)        
        end
    end
    return true
end


function tocar_cableRojo(event)

    if event.phase == "began" then
        cableRojo = display.newLine( CW/2-100, CH/2-40, CW/2-80, CH/2-80 )
        cableRojo:setStrokeColor( 1, 0, 0 )
        cableRojo.strokeWidth = 5

        cableRojo.isVisible = true
    elseif event.phase == "moved" then
        if event.x == CW/2-100 and event.y == CH/2-40 then
            cableRojo:append( event.x, event.y)
        end      
    end
    return true
end

]]

--[[
cableRosado = display.newLine( CW/2-100, CH/2-80, CW/2-80, CH/2-80 )
cableRosado:append( CW/2,CH/2, CW, CH, 0,0 )
cableRosado:setStrokeColor( 1, 0, 1 )
cableRosado.strokeWidth = 5
cableRosado.isVisible = true
]]
--[[
local lineaRosada
local cable
local puntosLinea = {}  -- Almacenar los puntos de la línea

local function dibujar(event)
    local fase = event.phase

    if fase == "began" then
        display.getCurrentStage():setFocus(event.target)
        event.target.isFocus = true

        -- Crear la línea rosada
        --lineaRosada = display.newLine(event.x, event.y, event.x, event.y)
        --lineaRosada:setStrokeColor(1, 0.4, 0.4)  -- Color rosado
        --lineaRosada.strokeWidth = 5

        -- Crear la línea roja inicial con la misma posición que la línea rosada
        cable = display.newLine (event.x, event.y, event.x, event.y )
        cable:setStrokeColor(1, 0, 0)  -- Color rojo
        cable.strokeWidth = 5

        -- Almacenar el punto inicial en la tabla
        puntosLinea = {
            {x = event.x, y = event.y}
        }

    elseif event.target and event.target.isFocus then
        if fase == "moved" then
            -- Actualizar la línea rosada mientras se mueve el mouse
            --lineaRosada:append(event.x, event.y)

            -- Almacenar el punto en la tabla
            table.insert(puntosLinea, {x = event.x, y = event.y})

            -- Actualizar la línea roja con los puntos de la tabla
            cable:removeSelf()  -- Eliminar la línea roja anterior
            cable = display.newLine(puntosLinea[1].x, puntosLinea[1].y, puntosLinea[#puntosLinea].x, puntosLinea[#puntosLinea].y)
            cable:setStrokeColor(1, 0, 0)  -- Color rojo
            cable.strokeWidth = 5

        elseif fase == "ended" or fase == "cancelled" then
            display.getCurrentStage():setFocus(nil)
            event.target.isFocus = false
        end
    end

    return true
end

]]

--local lineaRosada
local cables = {}
local puntosLinea = {}  -- Almacenar los puntos de la línea
local colores = {
    {1, 0, 1},     -- Rosado
    {1, 0, 0},     -- Rojo
    {0, 0, 1},     -- Azul
    {1, 1, 0},     -- Amarillo
}
local colorActualIndex = 1  -- Índice del color actual

local function dibujar(event)
    local fase = event.phase

    if fase == "began" then
        display.getCurrentStage():setFocus(event.target)
        event.target.isFocus = true

        -- Crear la línea rosada
        --lineaRosada = display.newLine(event.x, event.y, event.x, event.y)
        --lineaRosada:setStrokeColor(1, 0.4, 0.4)  -- Color rosado
        --lineaRosada.strokeWidth = 5

        -- Crear la cable inicial
        local cable = display.newLine(event.x, event.y, event.x, event.y)
        cable:setStrokeColor(unpack(colores[colorActualIndex]))  -- Color rosado inicial
        cable.strokeWidth = 5
        table.insert(cables, cable)

        -- Almacenar el punto inicial en la tabla
        puntosLinea = {
            {x = event.x, y = event.y}
        }

    elseif event.target and event.target.isFocus then
        if fase == "moved" then
            -- Actualizar la línea rosada mientras se mueve el mouse
            --lineaRosada:append(event.x, event.y)

            -- Almacenar el punto en la tabla
            table.insert(puntosLinea, {x = event.x, y = event.y})

            -- Actualizar la línea roja con los puntos de la tabla
            local cable = cables[#cables]
            cable:removeSelf()  -- Eliminar la línea roja anterior
            cable = display.newLine(puntosLinea[1].x, puntosLinea[1].y, puntosLinea[#puntosLinea].x, puntosLinea[#puntosLinea].y)
            cable:setStrokeColor(unpack(colores[colorActualIndex]))  -- Color actual
            cable.strokeWidth = 5
            table.insert(cables, cable)

        elseif fase == "ended" or fase == "cancelled" then
            display.getCurrentStage():setFocus(nil)
            event.target.isFocus = false

            -- Cambiar al siguiente color en cada clic
            colorActualIndex = colorActualIndex + 1
            if colorActualIndex > #colores then
                colorActualIndex = 1
            end
            -- Reiniciar la tabla de puntos para la próxima línea
            puntosLinea = {}
        end
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
    fondo = display.newImageRect(sceneGroup, rutaAssets.. "cables.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
    ----------------------------
    botonMenu = display.newRoundedRect(CW/2-180, CH/2-50, 81, 33, 4 )
    botonMenu:setFillColor( 0,0,0 )
    textoMenu = display.newText( "MENU", botonMenu.x, botonMenu.y , "Comic Sans MS", 10 )
    botonMenu.isVisible = false
    textoMenu.isVisible = false
    -------------------------
    --local lienzo = display.newRect(display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    --lienzo:setFillColor(1)
    --fondo:addEventListener("touch", tocar_cableRosado)


--[[
    cableRosado = display.newLine( CW/2-100, CH/2-80, CW/2-80, CH/2-80 )
    --cableRosado:append( CW/2,CH/2, CW, CH, 0,0 )
    cableRosado:setStrokeColor( 1, 0, 1 )
    cableRosado.strokeWidth = 5
    cableRosado.isVisible = false
]]
    --[[
    cableRosado = display.newLine( CW/2-100, CH/2-80, CW/2-80, CH/2-80)
    --star:append( 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, 0,-110 )
    cableRosado:setStrokeColor( 1, 0, 1 )
    cableRosado.strokeWidth = 5
    cableRosado.isVisible = false
]]
    --newRect( [parent,], x, y, width, height )
    --[[
    cableRosado = display.newRect( CW/2-100, CH/2-80, CW/2-80, CH/2-80 )
    cableRosado:setStrokeColor( 1, 0, 1 )
    cableRosado.isVisible = false
]]


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

        display.getCurrentStage():addEventListener("touch", dibujar)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        botonMenu:addEventListener("touch", irMenu)

        -- Agregar un evento táctil a toda la pantalla
        --display.getCurrentStage():addEventListener("touch", dibujar)

        --fondo:addEventListener("touch", tocar_cableRosado)
        --fondo:addEventListener("touch", tocar_cableRojo)

        --cableRosado:addEventListener( "touch", tocar_cableRosado )
        --cableRosado.isVisible = true

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

        display.getCurrentStage():removeEventListener("touch", dibujar)
        --lineaRosada:removeSelf()
        --cable:removeSelf()
        for i = 1, #cables do
            cables[i].isVisible = false
            --cables[i]:remove
            --cables[i] = nil
        end

        --lineasRosadas = {}
        --cables = {}
        puntosLinea = {}

        --fondo:removeEventListener("touch", tocar_cableRosado)
        --cableRosado.isVisible=false

        --fondo:removeEventListener("touch", tocar_cableRojo)
        --cableRojo.isVisible=false

        -- Agregar un evento táctil a toda la pantalla
        --display.getCurrentStage():removeEventListener("touch", dibujar)
        --cable.isVisible = false


        --cableRosado:removeEventListener( "touch", tocar_cableRosado )
        --cableRosado.isVisible = false

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

        --botonMenu.isVisible=false
        --textoMenu.isVisible=false
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Eliminar los objetos y limpiar memoria aquí
    --event.target.isFocus = false
    --display.getCurrentStage():removeEventListener("touch", dibujar)
    --lineaRosada:removeSelf()
    --cable:removeSelf()
 
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