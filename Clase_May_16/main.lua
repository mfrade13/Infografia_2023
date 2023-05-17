-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local linea = display.newLine(0,0, 320,480)

local CW = display.contentWidth
local CH = display.contentHeight

print( CW, CH )

local ACW = display.actualContentWidth
local ACH = display.actualContentHeight

print( ACW, ACH )

local linea_mitad = display.newLine(0,240,ACH,240)
linea_mitad.strokeWidth = 10

linea_mitad:setStrokeColor( 1, 0, 0 )

local vertices = { 0,0, 0,30, 30,30, 30,0 }
local vertices2 = { 0,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, }

local poligono = display.newPolygon( CW/2, CH/2, vertices2 )
