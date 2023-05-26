---------- Background ----------
local screenHeight = display.actualContentHeight
local lienzoHeight = screenHeight * 0.75
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

function createButton(nx, ny, h, w, message, action, figureSize, imagePath)
    local buttonGroup = display.newGroup()

    local button = display.newRoundedRect(buttonGroup, nx, ny, h, w, 12)
    -- local text = display.newText(buttonGroup, message, button.x, button.y, native.systemFont, 16)
    -- text:setFillColor(unpack(grey))

    local image = display.newImageRect(buttonGroup, imagePath, 150, 150)
    local imageAspect = image.width / image.height
    local imageSize = math.min(h, w)
    image.width = imageSize
    image.height = imageSize / imageAspect
    image.x = button.x
    image.y = button.y
    image:toFront()

    local function buttonTouch(event)
        if event.phase == "began" then
            button.fill = {0.7, 0.7, 0.7}
        elseif event.phase == "ended" or event.phase == "cancelled" then
            button.fill = paint
            action(figureSize)
        end
        return true
    end

    button:addEventListener("touch", buttonTouch)
    button.fill = paint

    return buttonGroup
end

local drawingButton = createButton(60, 30, 80, 40, "Draw", enableDrawing, nil,"pencil.png")
local erasingButton = createButton(160, 30, 80, 40, "Erase", enableErasing, nil, "eraser.png")
local cleaningButton = createButton(260, 30, 80, 40, "Clean", enableNewScreen, nil, "clean.png")
local triangleButton = createButton(110, 450, 80, 40, "Triangle", triangle, trMedium, "triangle.png")
local sButton        = createButton(3  , 450, 20, 30, "1"       , triangle, trSmall, "1.png")
local mButton        = createButton(28 , 450, 20, 30, "2"       , triangle, trMedium, "2.png")
local lButton        = createButton(53 , 450, 20, 30, "3"       , triangle, trLarge, "3.png")
local squareButton   = createButton(210, 450, 80, 40, "Square"  , square, sqMedium, "square.png")
local sButton        = createButton(270, 450, 20, 30, "1"       , square, sqSmall, "1.png")
local mButton        = createButton(295, 450, 20, 30, "2"       , square, sqMedium, "2.png")
local lButton        = createButton(320, 450, 20, 30, "3"       , square, sqLarge, "3.png")

lienzo:addEventListener("touch", dibujarOBorrar)
lienzo:addEventListener("tap"  , insertarFigura)
