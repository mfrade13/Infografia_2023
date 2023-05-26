local windowWidth = display.contentWidth
local windowHeight = display.contentHeight

local composer = require("composer")
local scene = composer.newScene()

local tableWidth = 8
local tableHeight = 4

local spacing = 2

local cellWidth = (windowWidth - spacing * (tableWidth + 1)) / tableWidth
local cellHeight = (windowHeight - spacing * (tableHeight + 1)) / tableHeight

local elements = {
    {symbol = "H", name = "Hidrógeno", atomicNumber = 1, orbitals = {1}, electrons = {1}, neutrons = 0},
    {symbol = "He", name = "Helio", atomicNumber = 2, orbitals = {1, 2}, electrons = {2}, neutrons = 2},
    {symbol = "Li", name = "Litio", atomicNumber = 3, orbitals = {1, 2}, electrons = {2, 1}, neutrons = 4},
    {symbol = "Be", name = "Berilio", atomicNumber = 4, orbitals = {1, 2}, electrons = {2, 2}, neutrons = 5},
    {symbol = "B", name = "Boro", atomicNumber = 5, orbitals = {1, 2, 3}, electrons = {2, 3}, neutrons = 6},
    {symbol = "C", name = "Carbono", atomicNumber = 6, orbitals = {1, 2, 3}, electrons = {2, 4}, neutrons = 6},
    {symbol = "N", name = "Nitrógeno", atomicNumber = 7, orbitals = {1, 2, 3}, electrons = {2, 5}, neutrons = 7},
    {symbol = "O", name = "Oxígeno", atomicNumber = 8, orbitals = {1, 2, 3}, electrons = {2, 6}, neutrons = 8},
    {symbol = "F", name = "Flúor", atomicNumber = 9, orbitals = {1, 2, 3}, electrons = {2, 7}, neutrons = 10},
    {symbol = "Ne", name = "Neón", atomicNumber = 10, orbitals = {1, 2, 3}, electrons = {2, 8}, neutrons = 10},
    {symbol = "Na", name = "Sodio", atomicNumber = 11, orbitals = {1, 2, 3}, electrons = {2, 8, 1}, neutrons = 12},
    {symbol = "Mg", name = "Magnesio", atomicNumber = 12, orbitals = {1, 2, 3}, electrons = {2, 8, 2}, neutrons = 12},
    {symbol = "Al", name = "Aluminio", atomicNumber = 13, orbitals = {1, 2, 3}, electrons = {2, 8, 3}, neutrons = 14},
    {symbol = "Si", name = "Silicio", atomicNumber = 14, orbitals = {1, 2, 3, 4}, electrons = {2, 8, 4}, neutrons = 14},
    {symbol = "P", name = "Fósforo", atomicNumber = 15, orbitals = {1, 2, 3, 4, 5}, electrons = {2, 8, 5}, neutrons = 16},
    {symbol = "S", name = "Azufre", atomicNumber = 16, orbitals = {1, 2, 3, 4, 5, 6}, electrons = {2, 8, 6}, neutrons = 16},
    {symbol = "Cl", name = "Cloro", atomicNumber = 17, orbitals = {1, 2, 3, 4, 5, 6, 7}, electrons = {2, 8, 7}, neutrons = 18},
    {symbol = "Ar", name = "Argón", atomicNumber = 18, orbitals = {1, 2, 3, 4, 5, 6, 7}, electrons = {2, 8, 8}, neutrons = 22},
    {symbol = "K", name = "Potasio", atomicNumber = 19, orbitals = {1, 2, 3, 4, 5, 6, 7, 8}, electrons = {2, 8, 8, 1}, neutrons = 20},
    {symbol = "Ca", name = "Calcio", atomicNumber = 20, orbitals = {1, 2, 3, 4, 5, 6, 7, 8}, electrons = {2, 8, 8, 2}, neutrons = 20},
    {symbol = "Sc", name = "Escandio", atomicNumber = 21, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 9, 2}, neutrons = 24},
    {symbol = "Ti", name = "Titanio", atomicNumber = 22, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 10, 2}, neutrons = 26},
    {symbol = "V", name = "Vanadio", atomicNumber = 23, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 11, 2}, neutrons = 28},
    {symbol = "Cr", name = "Cromo", atomicNumber = 24, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 13, 1}, neutrons = 28},
    {symbol = "Mn", name = "Manganeso", atomicNumber = 25, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 13, 2}, neutrons = 30},
    {symbol = "Fe", name = "Hierro", atomicNumber = 26, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 14, 2}, neutrons = 30},
    {symbol = "Co", name = "Cobalto", atomicNumber = 27, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 15, 2}, neutrons = 32},
    {symbol = "Ni", name = "Níquel", atomicNumber = 28, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 16, 2}, neutrons = 31},
    {symbol = "Cu", name = "Cobre", atomicNumber = 29, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 18, 1}, neutrons = 35},
    {symbol = "Zn", name = "Zinc", atomicNumber = 30, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 18, 2}, neutrons = 35},
    {symbol = "Ga", name = "Galio", atomicNumber = 31, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, electrons = {2, 8, 18, 3}, neutrons = 39},
    {symbol = "Ge", name = "Germanio", atomicNumber = 32, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, electrons = {2, 8, 18, 4}, neutrons = 41}
    --....
}

local function onCellClick(event)
    if event.phase == "ended" then
        local cell = event.target
        print("Celda clickeada:", cell.element.symbol, cell.element.name, cell.element.atomicNumber)
        local options = {
            effect = "zoomOutIn",
            time = 500,
            params = {
                elemento = cell.element
            }
        }
        composer.gotoScene("atom", options)
    end
    print ("verdadero")
    return true
    
end



function scene:create(event)
    local sceneGroup = self.view

    for i = 1, tableWidth * tableHeight do
        local row = math.floor((i - 1) / tableWidth)
        local column = (i - 1) % tableWidth

        local x = spacing + column * (cellWidth + spacing)
        local y = spacing + row * (cellHeight + spacing)

        local cell = display.newRect(sceneGroup, x, y, cellWidth, cellHeight)
        cell.strokeWidth = 1
        cell.anchorX, cell.anchorY = 0,0
        cell:setStrokeColor(0, 0, 0)

        local element = elements[i]
        cell.element = element

        local symbolLabel = display.newText({
            text = element.symbol,
            x = x+cellWidth/2,
            y = y + cellHeight / 2,
            font = native.systemFont,
            fontSize = 40
            
        })
        symbolLabel:setFillColor(0, 0, 0)

        local atomicNumberLabel = display.newText({
            text = tostring(element.atomicNumber),
            x = x+cellWidth/2 + 45,
            y = y + cellHeight / 2 - 70,
            font = native.systemFont,
            fontSize = 24
        })
        atomicNumberLabel:setFillColor(0, 0, 0)

        local nameLabel = display.newText({
            text = element.name,
            x = x+cellWidth/2,
            y = y + cellHeight / 2 + 35,
            font = native.systemFont,
            fontSize = 24
        })
        nameLabel:setFillColor(0, 0, 0)

        cell:addEventListener("touch", onCellClick)
    end
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
        --composer.removeScene("atom")
        
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --fondo:removeEventListener("touch", fondo)
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene