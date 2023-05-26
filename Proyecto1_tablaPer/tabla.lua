
local composer = require("composer")
local scene = composer.newScene()

local tableWidth = 8
local tableHeight = 4

local spacing = 2

local cellWidth = (CW - spacing * (tableWidth + 1)) / tableWidth
local cellHeight = (CH - spacing * (tableHeight + 1)) / tableHeight

local Ghotamfont = native.newFont("fonts/GothamBold.ttf")
local GhotamLIfont = native.newFont("fonts/GothamLightItalic.ttf")
local GhotamMed = native.newFont("fonts/GothamMedium_1.ttf")

local atomScene = composer.getScene("atom")

local elements = {
    {symbol = "H", name = "Hidrógeno", atomicNumber = 1, orbitals = {1}, electrons = {1}, neutrons = 0, atomWeight = 1.008},
    {symbol = "He", name = "Helio", atomicNumber = 2, orbitals = {1, 2}, electrons = {2}, neutrons = 2, atomWeight = 4.0026},
    {symbol = "Li", name = "Litio", atomicNumber = 3, orbitals = {1, 2}, electrons = {2, 1}, neutrons = 4, atomWeight = 6.94},
    {symbol = "Be", name = "Berilio", atomicNumber = 4, orbitals = {1, 2}, electrons = {2, 2}, neutrons = 5, atomWeight = 9.0122},
    {symbol = "B", name = "Boro", atomicNumber = 5, orbitals = {1, 2, 3}, electrons = {2, 3}, neutrons = 6, atomWeight = 10.81},
    {symbol = "C", name = "Carbono", atomicNumber = 6, orbitals = {1, 2, 3}, electrons = {2, 4}, neutrons = 6, atomWeight = 12.011},
    {symbol = "N", name = "Nitrógeno", atomicNumber = 7, orbitals = {1, 2, 3}, electrons = {2, 5}, neutrons = 7, atomWeight = 14.007},
    {symbol = "O", name = "Oxígeno", atomicNumber = 8, orbitals = {1, 2, 3}, electrons = {2, 6}, neutrons = 8, atomWeight = 15.999},
    {symbol = "F", name = "Flúor", atomicNumber = 9, orbitals = {1, 2, 3}, electrons = {2, 7}, neutrons = 10, atomWeight = 18.998},
    {symbol = "Ne", name = "Neón", atomicNumber = 10, orbitals = {1, 2, 3}, electrons = {2, 8}, neutrons = 10, atomWeight = 20.180},
    {symbol = "Na", name = "Sodio", atomicNumber = 11, orbitals = {1, 2, 3}, electrons = {2, 8, 1}, neutrons = 12, atomWeight = 22.990},
    {symbol = "Mg", name = "Magnesio", atomicNumber = 12, orbitals = {1, 2, 3}, electrons = {2, 8, 2}, neutrons = 12, atomWeight = 24.305},
    {symbol = "Al", name = "Aluminio", atomicNumber = 13, orbitals = {1, 2, 3}, electrons = {2, 8, 3}, neutrons = 14, atomWeight = 26.982},
    {symbol = "Si", name = "Silicio", atomicNumber = 14, orbitals = {1, 2, 3, 4}, electrons = {2, 8, 4}, neutrons = 14, atomWeight = 28.085},
    {symbol = "P", name = "Fósforo", atomicNumber = 15, orbitals = {1, 2, 3, 4, 5}, electrons = {2, 8, 5}, neutrons = 16, atomWeight = 30.974},
    {symbol = "S", name = "Azufre", atomicNumber = 16, orbitals = {1, 2, 3, 4, 5, 6}, electrons = {2, 8, 6}, neutrons = 16, atomWeight = 32.06},
    {symbol = "Cl", name = "Cloro", atomicNumber = 17, orbitals = {1, 2, 3, 4, 5, 6, 7}, electrons = {2, 8, 7}, neutrons = 18, atomWeight = 35.45},
    {symbol = "Ar", name = "Argón", atomicNumber = 18, orbitals = {1, 2, 3, 4, 5, 6, 7}, electrons = {2, 8, 8}, neutrons = 22, atomWeight = 39.948},
    {symbol = "K", name = "Potasio", atomicNumber = 19, orbitals = {1, 2, 3, 4, 5, 6, 7, 8}, electrons = {2, 8, 8, 1}, neutrons = 20, atomWeight = 39.098},
    {symbol = "Ca", name = "Calcio", atomicNumber = 20, orbitals = {1, 2, 3, 4, 5, 6, 7, 8}, electrons = {2, 8, 8, 2}, neutrons = 20, atomWeight = 40.078},
    {symbol = "Sc", name = "Escandio", atomicNumber = 21, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 9, 2}, neutrons = 24, atomWeight = 44.956},
    {symbol = "Ti", name = "Titanio", atomicNumber = 22, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 10, 2}, neutrons = 26, atomWeight = 47.867},
    {symbol = "V", name = "Vanadio", atomicNumber = 23, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 11, 2}, neutrons = 28, atomWeight = 50.942},
    {symbol = "Cr", name = "Cromo", atomicNumber = 24, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 13, 1}, neutrons = 28, atomWeight = 51.996},
    {symbol = "Mn", name = "Manganeso", atomicNumber = 25, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 13, 2}, neutrons = 30, atomWeight = 54.938},
    {symbol = "Fe", name = "Hierro", atomicNumber = 26, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 14, 2}, neutrons = 30, atomWeight = 55.845},
    {symbol = "Co", name = "Cobalto", atomicNumber = 27, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 15, 2}, neutrons = 32, atomWeight = 58.933},
    {symbol = "Ni", name = "Níquel", atomicNumber = 28, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 16, 2}, neutrons = 31, atomWeight = 58.693},
    {symbol = "Cu", name = "Cobre", atomicNumber = 29, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 18, 1}, neutrons = 35, atomWeight = 63.546},
    {symbol = "Zn", name = "Zinc", atomicNumber = 30, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9}, electrons = {2, 8, 18, 2}, neutrons = 35, atomWeight = 65.38},
    {symbol = "Ga", name = "Galio", atomicNumber = 31, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, electrons = {2, 8, 18, 3}, neutrons = 39, atomWeight = 69.723},
    {symbol = "Ge", name = "Germanio", atomicNumber = 32, orbitals = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}, electrons = {2, 8, 18, 4}, neutrons = 41, atomWeight = 72.630}
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

    local fondo = display.newImageRect(sceneGroup, "Fondo/fondo.jpg",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2

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

        local symbolLabel = display.newText(sceneGroup, element.symbol, x+cellWidth/2, y + cellHeight / 2, Ghotamfont, 50)
        symbolLabel:setFillColor(0, 0, 0)

        local atomicNumberLabel = display.newText(sceneGroup, tostring(element.atomicNumber), x+cellWidth/2 + 45, y + cellHeight / 2 - 70, GhotamMed, 24)
        atomicNumberLabel:setFillColor(0, 0, 0)

        local nameLabel = display.newText(sceneGroup, element.name, x+cellWidth/2, y + cellHeight / 2 + 50, GhotamMed, 20)
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
        --composer.removeScene("atom")
        if atomScene then
        --composer.removeScene("atom")
        else

        end
        print("Dentro del will de la funcion show")

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("Dentro del did de la funcion show")
        
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