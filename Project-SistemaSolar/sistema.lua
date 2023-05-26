local composer = require( "composer" )
local widget = require( "widget" )
 
local worldGroup = display.newGroup()
local fondo

local scene = composer.newScene()

local tPrevious = system.getTimer()

local altura = CH/4
local ancho = CW/12

local fondo
local grupoGrillas

-- Default to top-left anchor point for new objects
-- display.setDefault( "anchorX", 0.0 )
-- display.setDefault( "anchorY", 0.0 )

-- Create a container for the entire scene
local sceneContainer = display.newContainer( worldGroup, 1024, 768 )
sceneContainer.x, sceneContainer.y = 0,0
sceneContainer.anchorX = 0; sceneContainer.anchorY = 0
sceneContainer.anchorChildren = false

local sol
local mercurio
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
    fondo_sistema = {
        type = "image",
        filename = "Assets/space1.jpg"
    }
    local sceneGroup = self.view
    grupoGrillas = display.newGroup()

    fondo = display.newRect( sceneGroup, 0, 0, CW, CH)
    fondo.x, fondo.y = 0,0
    fondo.anchorX = 0; fondo.anchorY = 0
    fondo.fill = fondo_sistema

    for i=1,4 do
        local line = display.newLine(grupoGrillas, 0, altura*i, CW, altura*i)
        line.strokeWidth = 2
        line:setStrokeColor(1,1,1,0.2)
    end

    for i=1,12 do
        local line = display.newLine(grupoGrillas, ancho*i, 0, ancho*i, CH)
        line.strokeWidth = 2
        line:setStrokeColor(1,1,1,0.2)
    end

    sol = display.newImageRect(sceneContainer, "Assets/sol.png",426/3,405/3)
    sol.x = 2*ancho; sol.y = 2*altura

    mercurio = display.newImageRect(sceneContainer, "Assets/mercurio.png",426/8,405/8)
    mercurio.x = 3*ancho; mercurio.y = 2*altura

    venus = display.newImageRect(sceneContainer, "Assets/venus.png",426/7.5,405/7.5)
    venus.x = 4*ancho; venus.y = 2*altura

    tierra = display.newImageRect(sceneContainer, "Assets/tierra.png",426/7.5,405/7.5)
    tierra.x = 5*ancho; tierra.y = 2*altura

    marte = display.newImageRect(sceneContainer, "Assets/marte.png",426/8,405/8)
    marte.x = 6*ancho; marte.y = 2*altura

    jupiter = display.newImageRect(sceneContainer, "Assets/jupiter.png",426/3.5,405/3.5)
    jupiter.x = 7*ancho; jupiter.y = 2*altura

    saturno = display.newImageRect(sceneContainer, "Assets/saturno.png",426/4,405/4)
    saturno.x = 8*ancho; saturno.y = 2*altura

    urano = display.newImageRect(sceneContainer, "Assets/urano.png",426/5,405/5)
    urano.x = 9*ancho; urano.y = 2*altura

    neptuno = display.newImageRect(sceneContainer, "Assets/neptuno.png",426/5,405/5)
    neptuno.x = 10*ancho; neptuno.y = 2*altura

    -- On/off switch
	local onOffSwitch = widget.newSwitch {
		style = "onOff",
		initialSwitchState = false
	}
	onOffSwitch.y = altura*3.6; onOffSwitch.x = ancho 
	sceneGroup:insert( onOffSwitch )
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
 

 
local function move( event )
    local tDelta = (event.time - tPrevious)
    tPrevious = event.time
    --local xOffset = ( 0.2*tDelta )

    local periodo_mercurio = 50
    local radio_S2Mercurio = ancho
    local W_mercurio = 2*(math.pi)/periodo_mercurio

    local angulo = 0.2 * tDelta
    local x_prima = mercurio.x - sol.x
    local y_prima = mercurio.y - sol.y
    mercurio.x = math.cos(math.rad(angulo))*mercurio.x - math.sin(math.rad(angulo))*mercurio.y
    mercurio.y = math.sin(math.rad(angulo))*mercurio.x + math.cos(math.rad(angulo))*mercurio.y

    --x_prima = math.cos(math.rad(angulo))*mercurio.x - math.sin(math.rad(angulo))*sol.x
    --y_prima = math.sin(math.rad(angulo))*mercurio.y + math.cos(math.rad(angulo))*sol.y
    
    --mercurio.x = x_prima + sol.x
    --mercurio.y = y_prima + sol.y

    --mercurio.x = sol.x + (radio_S2Mercurio*math.cos(math.rad(angulo)*tDelta))
    print(mercurio.x, mercurio.y)
    --mercurio.y = sol.y + (radio_S2Mercurio*math.sin(math.rad(angulo)*tDelta))
end
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

Runtime:addEventListener("enterFrame",move)
-- -----------------------------------------------------------------------------------
 
return scene