-- Background
local screenHeight = display.actualContentHeight
local lienzoHeight = screenHeight * 0.75 -- 3/4 of the screen height
local lienzo = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, lienzoHeight)
lienzo:setFillColor(1) 

---------- Colors ----------
black  = { 0  , 0   , 0   }
white  = { 1  , 1   , 1   }
grey   = { 0.5, 0.5 , 0.5 }
red    = { 1  , 0   , 0   }
green  = { 0  , 1   , 0   }
blue   = { 0  , 0   , 1   }
orange = { 1  , 0.56, 0   }
yellow = { 1  , 1   , 0   }
purple = { 0.9, 0.9 , 0.98}

---------- Figures sizes ----------
trSmall  = {0, -30, 30, 30, -30, 30}
trMedium = {0, -50, 50, 50, -50, 50}
trLarge  = {0, -70, 70, 70, -70, 70}

sqSmall  = {x, y, 20, 20}
sqMedium = {x, y, 50, 50}
sqLarge  = {x, y, 80, 80}

local dibujando = false
local figuraActual = nil
local trSize = trMedium
local sqSize = sqMedium

local function dibujarOBorrar(event)
    if dibujando then
        local x = event.x
        local y = event.y
        
        if event.phase == "began" then
            linea = display.newLine(x, y, x, y)
            linea.strokeWidth = 2
            if dibujando == "dibujo" then
                linea:setStrokeColor(unpack( black )) 
                print("Drawing mode on")
            elseif dibujando == "borrado" then
                linea:setStrokeColor(unpack( white )) 
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
        local triangulo = display.newPolygon(x, y, trSize)
        triangulo:setFillColor(unpack(red))
        print( "Triangle printed" )
    elseif figuraActual == "cuadrado" then
        local cuadrado = display.newRect(x, y, sqSize[3], sqSize[4])
        cuadrado:setFillColor(unpack(green))
        print( "Square printed" )
    end
end

function triangle(st)
    dibujando    = false
    figuraActual = "triangulo"
    trSize       = st
end

function square(sq)
    dibujando    = false
    figuraActual = "cuadrado"
    sqSize       = sq
end

function enableNewScreen()
    local newScreen = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth, lienzoHeight)
    newScreen:setFillColor(1) 
    print( "-----------------------------------------" )
end
-------------------- Create Buttons --------------------

paint = {
    type = "gradient",
    color1 = green,
    color2 = yellow,
    direction = "right"
}

function createButton(nx, ny, h, w, message, action, figureSize)
    local button = display.newRoundedRect(nx, ny, h, w, 12)
    local text = display.newText(message, button.x, button.y, native.systemFont, 16)
    text:setFillColor(unpack(grey))
    
    local function buttonTouch(event)
        if event.phase == "began" then
            button.fill = {0.7, 0.7, 0.7}  -- Change the button color when pressed
        elseif event.phase == "ended" or event.phase == "cancelled" then
            button.fill = paint  -- Restore the original button color
            action(figureSize)  -- Execute the button action
        end
        return true
    end
    
    button:addEventListener("touch", buttonTouch)
    button.fill = paint
    
    return button
end


local drawingButton  = createButton(60 , 30 , 80, 40, "Draw"    , enableDrawing)
local erasingButton  = createButton(160, 30 , 80, 40, "Erase"   , enableErasing)
local cleaningButton = createButton(260, 30 , 80, 40, "Clean"   , enableNewScreen)
local triangleButton = createButton(110, 450, 80, 40, "Triangle", triangle, trMedium)
local sButton        = createButton(3  , 450, 20, 30, "1"       , triangle, trSmall)
local mButton        = createButton(28 , 450, 20, 30, "2"       , triangle, trMedium)
local lButton        = createButton(53 , 450, 20, 30, "3"       , triangle, trLarge)
local squareButton   = createButton(210, 450, 80, 40, "Square"  , square, sqMedium)
local sButton        = createButton(270, 450, 20, 30, "1"       , square, sqSmall)
local mButton        = createButton(295, 450, 20, 30, "2"       , square, sqMedium)
local lButton        = createButton(320, 450, 20, 30, "3"       , square, sqLarge)

lienzo:addEventListener("touch", dibujarOBorrar)
lienzo:addEventListener("tap"  , insertarFigura)
