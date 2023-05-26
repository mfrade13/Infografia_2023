-----------------------------------------------------------------------------------------
--
-- title.lua
--
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
-------------------------------------------
local CW = display.contentWidth
local CH = display.contentHeight
local pathAssets = "imagenes/"
local pageText
------------------------------------------
local function irMenu()
    composer.gotoScene("menu","fade")  -- nombre del archivo lua de la escena 1
end
------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
	local icono= display.newImageRect( sceneGroup, pathAssets.."logo.jpg", CW , CH )
	icono.x,icono.y = CW/2, CH/2
	
   	
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
	elseif phase == "did" then
	timer.performWithDelay(1000,irMenu)

		
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		
		
		
	elseif phase == "did" then
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene