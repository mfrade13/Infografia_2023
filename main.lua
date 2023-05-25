-- Background
local screenHeight = display.actualContentHeight
local lienzoHeight = screenHeight * 0.75 -- 3/4 of the screen height
local lienzo = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, lienzoHeight)
lienzo:setFillColor(1) 

---------- Colors ----------
black = { 0  , 0  , 0  }
white = { 1  , 1  , 1  }
grey  = { 0.5, 0.5, 0.5}
red   = { 1  , 0  , 0  }
green = { 0  , 1  , 0  }
blue  = { 0  , 0  , 1  }

---------- Figures sizes ----------
trSmall  = {0, -30, 30, 30, -30, 30}
trMedium = {0, -50, 50, 50, -50, 50}
trLarge  = {0, -70, 70, 70, -70, 70}

-- sqSmall  = 50, 50
-- sqMedium = 70, 70
-- sqLarge  = 90, 90

local dibujando = false
local figuraActual = nil

local function dibujarOBorrar(event)
    if dibujando then
        local x = event.x
        local y = event.y
        
        if event.phase == "began" then
            linea = display.newLine(x, y, x, y)
            linea.strokeWidth = 2
            if dibujando == "dibujo" then
                linea:setStrokeColor(0, 0, 0) -- Drawing color (black)
                print("Drawing mode on")
            elseif dibujando == "borrado" then
                linea:setStrokeColor(1, 1, 1) -- Erasing color (white)
                print("Erasing mode on")
            end
        elseif event.phase == "moved" then
            linea:append(x, y)
        end
    end
end

function enableDrawing()
    dibujando = "dibujo"
end

function enableErasing()
    dibujando = "borrado"
end

function insertarFigura(event)
    local x = event.x
    local y = event.y
    
    if figuraActual == "triangulo" then
        local triangulo = display.newPolygon(x, y, trLarge)
        triangulo:setFillColor(unpack(red))
        print( "Triangle printed" )
    elseif figuraActual == "cuadrado" then
        local cuadrado = display.newRect(x, y, 50, 50)
        cuadrado:setFillColor(unpack(green))
        print( "Square printed" )
    end
end

function triangle()
    dibujando    = false
    figuraActual = "triangulo"
end

function square()
    dibujando    = false
    figuraActual = "cuadrado"
end

function enableNewScreen()
    local newScreen = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, lienzoHeight)
    newScreen:setFillColor(1) 
    print( "-----------------------------------------" )
end
-------------------- Create Buttons --------------------
function createButton(nx, ny, message, action)
    local button = display.newRect(nx, ny, 80, 40)
    button:setFillColor( unpack( grey ) )
    local text = display.newText(message, button.x, button.y, native.systemFont, 16)
    text:setFillColor( unpack( white ) )
    button:addEventListener( "tap", action )
end

local drawingButton  = createButton(60 , 30 , "Draw"    , enableDrawing)
local erasingButton  = createButton(160, 30 , "Erase"   , enableErasing)
local cleaningButton = createButton(260, 30 , "Clean"   , enableNewScreen)
local triangleButton = createButton(110, 450, "Triangle", triangle)
local squareButton   = createButton(210, 450, "Square"  , square)

lienzo:addEventListener("touch", dibujarOBorrar)
lienzo:addEventListener("tap"  , insertarFigura)
