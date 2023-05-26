-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local total_ancho_pixeles = 24
local tap = total_ancho_pixeles
local total_alto_pixeles = 24
local ap = 24

local rosa = { 247/255, 191/255, 190/255}


local CW = display.contentWidth
local CH = display.contentHeight

local size_width = CW/tap
local size_height = CH/ap

local fondo = display.newRect(CW/2, CH/2, CW, CH)
fondo:setFillColor( 0, 1, 1, 0.4 )

print( size_width, size_height )
local lineas_horizontales = {}

for i=1, ap,1 do
	lineas_horizontales[i] =  display.newLine(0, i*size_height, CW, i*size_height )
	--lineas_horizontales:setStrokeColor( 1,0,0 )
	lineas_horizontales[i].strokeWidth = 3
end


for i=1, tap,1 do
	local lineas_verticales = display.newLine(i*size_width, 0, i*size_width, CH )
	lineas_verticales.strokeWidth = 3
end


--lineas_horizontales[10]:setStrokeColor( 1,1,0 )

local nariz_superior_blanca = display.newRect(0,0, size_width * 3, size_height  )
nariz_superior_blanca.x = 11 * size_width
nariz_superior_blanca.y = 13 * size_height
nariz_superior_blanca.anchorX = 0
nariz_superior_blanca.anchorY = 0

local oreja_rosa_izq = display.newRect( 8*size_width, 7*size_height, size_width *1, size_height *2  )
oreja_rosa_izq:setFillColor( unpack( rosa))
oreja_rosa_izq.anchorX = 0
oreja_rosa_izq.anchorY = 0

local oreja_rosa_der = display.newRect( 16*size_width, 7*size_height, size_width *1, size_height *2  )
oreja_rosa_der:setFillColor( 247/255, 191/255, 190/255 )
oreja_rosa_der.anchorX = 0
oreja_rosa_der.anchorY = 0

--bigotes
local bigote_izq1 = display.newRect( 3*size_width, 13*size_height, 3*size_width, size_height )
bigote_izq1:setFillColor( 0,0,0 )
bigote_izq1.anchorX, bigote_izq1.anchorY = 0,0 

local bigote_izq2 = display.newRect( 3*size_width, 15*size_height, 3*size_width, size_height )
bigote_izq2:setFillColor( 0,0,0 )
bigote_izq2.anchorX, bigote_izq2.anchorY = 0,0 

local bigote_der1 = display.newRect( 18*size_width, 13*size_height, 3*size_width, size_height )
bigote_der1:setFillColor( 0,0,0 )
bigote_der1.anchorX, bigote_der1.anchorY = 0,0 

local bigote_der2 = display.newRect( 18*size_width, 15*size_height, 3*size_width, size_height )
bigote_der2:setFillColor( 0,0,0 )
bigote_der2.anchorX, bigote_der2.anchorY = 0,0 


local ojo_izquierdo = display.newRect( 0, 0, size_width, size_height * 3)
ojo_izquierdo.x = 9 * size_width
ojo_izquierdo.y = 11 * size_height
ojo_izquierdo.anchorX = 0
ojo_izquierdo.anchorY = 0
ojo_izquierdo:setFillColor( white )

local black = {0,0,0}

local ojo_derecho = display.newRect( 0, 0, size_width, size_height * 3)
ojo_derecho.x = 15 * size_width
ojo_derecho.y = 11 * size_height
ojo_derecho.anchorX = 0
ojo_derecho.anchorY = 0
ojo_derecho:setFillColor( unpack( black) )

