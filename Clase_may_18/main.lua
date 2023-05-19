-----------------------------------------------------------------------------------------
--
local CW = display.contentWidth
local CH = display.contentHeight
display.setStatusBar(display.DarkStatusBar)

local fondo = display.newRect(0,0, CW, CH)
local linea = display.newLine(0,0, 320,480)
print( CW, CH )
local ACW = display.actualContentWidth
local ACH = display.actualContentHeight
print( ACW, ACH )
local linea_mitad = display.newLine(0,240,ACH,240)
linea_mitad.strokeWidth = 10
linea_mitad.alpha = 0.1
linea_mitad:setStrokeColor( 1, 0, 0 )

local vertices = { 0,0, 0,30, 30,30, 30,0 }
local vertices2 = { 0,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, }
local poligono = display.newPolygon( CW/2, CH/2, vertices )
poligono.nombre = "lUIGI"
poligono:toBack( )
fondo:toBack( )

local circulo = display.newCircle( 0, 0, 15 )
circulo.x = CW/2; circulo.y = 100
circulo:setFillColor( 0, 0, 1, 0.8 )
circulo.strokeWidth = 3
circulo:setStrokeColor( 1, 1 )
circulo.nombre = "Mario"

local cuadrado = display.newRect( 3*CW/4, 3*CH/4, 15, 15 )
cuadrado.anchorX = 0 ; cuadrado.anchorY = 1
fondo.anchorX = 0
fondo.anchorY = 0

fondo:setFillColor( 0.3 )

local texto = display.newText( "INFOGRAFIA", circulo.x, circulo.y , "arial", 20 )
--texto.x = CW/2; texto.y = 50
texto.text = "Usuario: Elian"
-- texto.text = "Usuario: Gabriel"
texto.anchorX = 0

local rounded_rect = display.newRoundedRect(cuadrado.x, cuadrado.y + 50, 15 ,15, 7 )

local fondo2 = display.newImageRect("1.jpg", CW, CH)
fondo2.x = CW/2; fondo2.y = CH/2
fondo2:toBack()

fondo.isVisible = false

--display.remove(fondo2)
--fondo2:removeSelf()

--fondo2:setFillColor(1,0,0)

local cabra = display.newImageRect("win.png", 592/8,820/8)
cabra.x = CW/2
cabra.y = CH/2
cabra.anchorY =1
cabra.rotation = 90
cabra.alpha = 0.7


function tocar(event)

    if event.phase == "began" then
        print("Inicio del evento touch")
    elseif event.phase == "moved" then
        print("Se esta moviendo el touch")
    elseif event.phase == "ended" then
        print("Fin del evento de la cabra")
    end
   -- return true
end

function tocar2(self, event)

    if event.phase == "began" then
        print("Inicio del evento touch")
    elseif event.phase == "moved" then
        print("Se esta moviendo el touch")
    elseif event.phase == "ended" then
        print("Fin del evento del poligono " .. self.nombre)
    end
    return true
end

function fondo2:touch(event)
    if event.phase == "ended" then
        print("Evento en el fondo")
    end
    return true
end


function circulo:describir()
    print("Hola soy un circulo y me llamo " .. self.nombre)
end

function circulo:touch(event)
    if event.phase == "began" then
        print("Inicio del evento touch")
    elseif event.phase == "moved" then
        print("Se esta moviendo el touch")
    elseif event.phase == "ended" then
        self:describir()
        print("Fin del evento" )
        print("Estoy en la posicion x:" .. tostring(self.x) .. " y:" .. tostring(self.y))
    end
end

poligono.touch = tocar2

local frutas = {}
function tocar_frutas(self, event)
    if event.phase == "ended" then
        print("Evento en la fruta " .. self.nombre)
    end
    return true
end

for i=1,10,1 do
    frutas[i] = display.newImageRect("f1.png", 30, 30 )
    frutas[i].x, frutas[i].y = math.random(10, CW), math.random(30, CH)
    frutas[i].nombre = "Fruta:" .. i


    frutas[i].touch = tocar_frutas
    frutas[i]:addEventListener("touch")
end


circulo:addEventListener("touch", circulo)
cabra:addEventListener("touch", tocar)
poligono:addEventListener("touch")
fondo2:addEventListener("touch")
