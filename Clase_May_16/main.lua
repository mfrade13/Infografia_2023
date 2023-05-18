-----------------------------------------------------------------------------------------
--
local CW = display.contentWidth
local CH = display.contentHeight

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
poligono:toBack( )
fondo:toBack( )

local circulo = display.newCircle( 0, 0, 15 )
circulo.x = CW/2; circulo.y = 100
circulo:setFillColor( 0, 0, 1, 0.8 )
circulo.strokeWidth = 3
circulo:setStrokeColor( 1, 1 )

local cuadrado = display.newRect( 3*CW/4, 3*CH/4, 15, 15 )
cuadrado.anchorX = 0 ; cuadrado.anchorY = 1
fondo.anchorX = 0
fondo.anchorY = 0

fondo:setFillColor( 0.3 )

local texto = display.newText( "INFOGRAFIA", circulo.x, circulo.y , "arial", 20 )
--texto.x = CW/2; texto.y = 50
texto.text = "Usuario: "
-- texto.text = "Usuario: Gabriel"
texto.anchorX = 0

