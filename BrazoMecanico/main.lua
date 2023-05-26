

-- Definir propiedades del brazo mecánico


local CW = display.contentWidth
local CH = display.contentHeight

print( CW, CH)

local ACW = display.actualContentWidth
local ACH = display.actualContentHeight
print( ACW, ACH)



--- creare la variable "Motor seleccionado", que va a ir del 1 al 4, donde 1 es el motor que hace rotar el primer eslabon y 4 el motor que hace rotar la pinza
local motor = 1
local ancho = 20
local angulo1 = 15
local angulo2 = 0
local angulo3 = 90
local angulo4 = 0
local abierto = true --la variable que indica si la pinza está abierta o cerrada
local largo1 = 50
local largo2 = 50
local largo3 = 50
local largo4 = 50
local velocidadAngular = 0
local abierto = true

-------------------------------------------------------------------------------------------------------
--CREACION DEL FONDO
--El fondo lo dividire en 3 partes, la mitad superior tendra al brazo mecanico
-- El primer cuarto inferior tendra los dadots del brazo robotico (angulos y estado de la pinza)
-- El ultimo cuarto lo usaré para controlar el brazo robótico
------------------------------------------------------------------------------------------------------
----LA MITAD SUPERIOR TIENE QUE TENER UN FONDO DE FABRICA

--Para eso, dibujare una rectangulo que la rellenaré de mi imagen 
local function dibujar()
local image = display.newImageRect("Imagenes/Fondo1.jpg", CW, CH/2)
local rect = display.newRect(0, 0, 0,0)
image.x = CW/2
image.y = CH/4  -- la ubicacion esta pensada para que mi fondo ocupe especificamente todo arriba de mi recta


--luego de eso establezco una linea divisora entre lo que son datos y lo que es el esenario


local image = display.newImageRect("Imagenes/AZULOSCURO.jpg", CW, CH/4)
local rect = display.newRect(0, 0, 0,0)
image.x = CW/2
image.y = CH/8*5  

local linea_divisora1 = display.newLine(0, CH/4*3, CW,CH/4*3 ) -- Traza linea de x1 y1 a x2 y2
linea_divisora1.strokeWidth = 5 --engruesa la linea
linea_divisora1:setStrokeColor(53, 56 ,54) --pinta la linea en formato RGB

--luego de eso otra linea_divisora entre los datos y los controles

local image = display.newImageRect("Imagenes/AZULCLARO.png", CW, CH/4)
local rect = display.newRect(0, 0, 0,0)
image.x = CW/2
image.y = CH/8*7  



local linea_divisora1 = display.newLine(0, CH/4*3, CW,CH/4*3 ) -- Traza linea de x1 y1 a x2 y2
linea_divisora1.strokeWidth = 5 --engruesa la linea
linea_divisora1:setStrokeColor(53, 56 ,54) --pinta la linea en formato RGB

local linea_divisora2 = display.newLine(0, CH/2, CW,CH/2 ) -- Traza linea de x1 y1 a x2 y2
linea_divisora2.strokeWidth = 5 --engruesa la linea
linea_divisora2:setStrokeColor(53, 56 ,54) --pinta la linea en formato RGB

---------------------------------------------------------------------------------
--- CREACION DE BRAZO ROBOTICO Y SUS PARAMETROS
-----------------------------------------------------------------------------------

--Creare los botones que haran girar el eslabon mecanico seleccionado

--Va a hacer que rote en direccion izquierda o antihoraria 
local buttonMover = display.newImageRect("Imagenes/BotonFlecha.png", 45, 45)
buttonMover.x = CW/8
buttonMover.y = CH*15/16
buttonMover.rotation = 45


-- Crearé los botones que definen la velocidad angular con la que se rota

local buttonAumentarVelocidad = display.newImageRect("Imagenes/BotonFlecha.png", 40,50)
buttonAumentarVelocidad.x = CW * 5/8
buttonAumentarVelocidad.y = CH * 13/16
buttonAumentarVelocidad.rotation = 90


local buttonReducirVelocidad = display.newImageRect("Imagenes/BotonFlecha.png", 40,50)
buttonReducirVelocidad.x = CW * 5/8
buttonReducirVelocidad.y = CH * 15/16
buttonReducirVelocidad.rotation = 270

local linea_divisora3 = display.newLine(CW/2, CH*3/4, CW/2,CH ) -- Traza linea de x1 y1 a x2 y2
linea_divisora3.strokeWidth = 5 --engruesa la linea
linea_divisora3:setStrokeColor(53, 56 ,54) --pinta la linea en formato RGB


-- Crearé los textos que se modifican cuando preciono los botones de incrementar o de reducir la velocidad

TextoVelocidadMotor1 = display.newText("Motor 1: " .. angulo1, CW * 1/4, CH * 11/20, "Comic Sans MS", 13)
TextoVelocidadMotor2 = display.newText("Motor 2: " .. angulo2, CW * 1/4, CH * 12/20, "Comic Sans MS", 13)
TextoVelocidadMotor3 = display.newText("Motor 3: " .. angulo3, CW * 1/4, CH * 13/20, "Comic Sans MS", 13)
TextoVelocidadMotor4 = display.newText("Motor 4: " .. angulo4, CW * 1/4, CH * 14/20, "Comic Sans MS", 13)
TextoAdornoGarra = display.newText("GARRA", CW * 3/4, CH * 12/20, "Comic Sans MS", 13)
local CuadroGarra = display.newRect( CW * 3/4, CH * 13/20,70 ,30)
CuadroGarra:setFillColor(0,0,0)
TextoGarra= display.newText("" .. angulo2, CW * 3/4, CH * 13/20, "Comic Sans MS", 13)
if abierto == true then
    TextoGarra.text = "ABIERTO"
else
    TextoGarra.text = "CERRADO"
end

local function AbrirCerrarGarra(event)
    if event.phase == "ended" then
        if (abierto == true) then
            abierto = false
            dibujar()
        else
            abierto = true
            dibujar()
        end
    end
    return true
end
CuadroGarra:addEventListener("touch",AbrirCerrarGarra)


TextoAdornoVelocidad = display.newText("VELOCIDAD", CW * 7/8, CH * 13/16, "Comic Sans MS", 13)
TextoVelocidad = display.newText(velocidadAngular, CW * 7/8, CH * 14/16, "Comic Sans MS", 20)

local function actualizarTextoVelocidad()
    TextoVelocidad.text = velocidadAngular
end

local function AumentarVelocidad(event)
    if event.phase == "ended" then
        velocidadAngular = velocidadAngular + 1
        actualizarTextoVelocidad()
    end
    return true
end

local function ReducirVelocidad(event)
    if event.phase == "ended" then
        velocidadAngular = velocidadAngular - 1
        actualizarTextoVelocidad()
    end
    return true
end

buttonAumentarVelocidad:addEventListener("touch", AumentarVelocidad)
buttonReducirVelocidad:addEventListener("touch", ReducirVelocidad)


local function Mover(event)
    if event.phase == "ended" then
        if motor == 1 then
            angulo1 = angulo1 + velocidadAngular
        end
        if motor == 2 then
            angulo2 = angulo2 + velocidadAngular
        end
        if motor == 3 then
            angulo3 = angulo3 + velocidadAngular
        end
        if motor == 4 then
            angulo4 = angulo4 + velocidadAngular
        end
        dibujar()
    end
    return true
end

buttonMover:addEventListener("touch", Mover)
TextoMotorSeleccionado = display.newText("",CW * 1/4, CH * 13/16, "Comic Sans MS", 25 )
if motor == 1 then
    TextoMotorSeleccionado.text = "Motor 1"
end
if motor == 2 then
    TextoMotorSeleccionado.text = "Motor 2"
end
if motor == 3 then
    TextoMotorSeleccionado.text = "Motor 3"
end
if motor == 4 then
    TextoMotorSeleccionado.text = "Motor 4"
end

local texto = display.newText("Brazo mecanico", display.contentCenterX, display.contentCenterY*1/7, native.systemFont, 24)
texto:setFillColor(1, 1, 1) -- Blanco
-- Dibujar rectángulo
local rect1 = display.newRect(display.contentCenterX, display.contentCenterY, largo1,ancho)
rect1:setFillColor(1, 0.5, 0) -- Naranja
rect1.strokeWidth = 2
rect1:setStrokeColor(0, 0, 0) -- Negro
rect1.anchorX=0 ; rect1.anchorY=0.5
rect1.rotation = -angulo1
local function SelectMotor1(event)
    if event.phase == "ended" then
        motor = 1
        TextoMotorSeleccionado.text = "Motor 1"
    end
    return true
end
rect1:addEventListener("touch", SelectMotor1)

-- Dibujar círculos en los extremos
local circle01 = display.newCircle(CW/2, CH/2, 10)
circle01:setFillColor(1, 1, 0) -- Amarillo
circle01.strokeWidth = 2
circle01:setStrokeColor(0, 0, 0) -- Negro

local circle02 = display.newCircle(rect1.x+largo1*math.cos(math.rad(angulo1)) , rect1.y-largo1*math.sin(math.rad(angulo1)), 10)
circle02:setFillColor(1, 1, 0) -- Amarillo
circle02.strokeWidth = 2
circle02:setStrokeColor(0, 0, 0) -- Negro



-- Dibujar rectángulo
local rect2 = display.newRect(rect1.x+largo1*math.cos(math.rad(angulo1)) , rect1.y-largo1*math.sin(math.rad(angulo1)),largo2 ,ancho)
rect2:setFillColor(1, 0.5, 0) -- Naranja
rect2.strokeWidth = 2
rect2:setStrokeColor(0, 0, 0) -- Negro
rect2.anchorX=0 ; rect1.anchorY=0.5
rect2.rotation = -angulo2
local function SelectMotor2(event)
    if event.phase == "ended" then
        motor = 2
        TextoMotorSeleccionado.text = "Motor 2"
    end
    return true
end
rect2:addEventListener("touch", SelectMotor2)

-- Dibujar círculos en los extremos
local circle10 = display.newCircle(rect1.x+largo1*math.cos(math.rad(angulo1)) , rect1.y-largo1*math.sin(math.rad(angulo1)), 10)
circle10:setFillColor(1, 1, 0) -- Amarillo
circle10.strokeWidth = 2
circle10:setStrokeColor(0, 0, 0) -- Negro

local circle11 = display.newCircle(rect2.x+largo1*math.cos(math.rad(angulo2)) , rect2.y-largo1*math.sin(math.rad(angulo2)), 10)
circle11:setFillColor(1, 1, 0) -- Amarillo
circle11.strokeWidth = 2
circle11:setStrokeColor(0, 0, 0) -- Negro



-- Dibujar rectángulo
local rect3 = display.newRect(rect2.x+largo1*math.cos(math.rad(angulo2)) , rect2.y-largo1*math.sin(math.rad(angulo2)),largo2 ,ancho)
rect3:setFillColor(1, 0.5, 0) -- Naranja
rect3.strokeWidth = 2
rect3:setStrokeColor(0, 0, 0) -- Negro
rect3.anchorX=0 ; rect1.anchorY=0.5
rect3.rotation = -angulo3
local function SelectMotor3(event)
    if event.phase == "ended" then
        motor = 3
        TextoMotorSeleccionado.text = "Motor 3"
    end
    return true
end
rect3:addEventListener("touch", SelectMotor3)

-- Dibujar círculos en los extremos
local circle20 = display.newCircle(rect2.x+largo1*math.cos(math.rad(angulo2)) , rect2.y-largo1*math.sin(math.rad(angulo2)), 10)
circle20:setFillColor(1, 1, 0) -- Amarillo
circle20.strokeWidth = 2
circle20:setStrokeColor(0, 0, 0) -- Negro

local circle21 = display.newCircle(rect3.x+largo1*math.cos(math.rad(angulo3)) , rect3.y-largo1*math.sin(math.rad(angulo3)), 10)
circle21:setFillColor(1, 1, 0) -- Amarillo
circle21.strokeWidth = 2
circle21:setStrokeColor(0, 0, 0) -- Negro

---------------------

local function SelectMotor4(event)
    if event.phase == "ended" then
        motor = 4
        TextoMotorSeleccionado.text = "Motor 4"
    end
    return true
end
if abierto == true then
    -- Dibujar rectángulo
local rect41 = display.newRect(rect3.x+largo1*math.cos(math.rad(angulo3)) , rect3.y-largo1*math.sin(math.rad(angulo3)),largo2 ,ancho)
rect41:setFillColor(1, 0.5, 0) -- Naranja
rect41.strokeWidth = 2
rect41:setStrokeColor(0, 0, 0) -- Negro
rect41.anchorX=0 ; rect1.anchorY=0.5
rect41.rotation = -angulo4
rect41:addEventListener("touch", SelectMotor4)
local cerrada1 = display.newRect(rect3.x+largo1*math.cos(math.rad(angulo3)) , rect3.y-largo1*math.sin(math.rad(angulo3)),largo2 ,ancho/2)
cerrada1:setFillColor(0,0,0)
cerrada1.anchorX=0 ; rect1.anchorY=0.5
cerrada1.rotation = -angulo4
cerrada1:addEventListener("touch", SelectMotor4)

else -- Dibujar rectángulo
    local rect42 = display.newRect(rect3.x+largo1*math.cos(math.rad(angulo3)) , rect3.y-largo1*math.sin(math.rad(angulo3)),largo2 ,ancho/2)
    rect42:setFillColor(1, 0.5, 0) -- Naranja
    rect42.strokeWidth = 2
    rect42:setStrokeColor(0, 0, 0) -- Negro
    rect42.anchorX=0 ; rect1.anchorY=0.5
    rect42.rotation = -angulo4
    rect42:addEventListener("touch", SelectMotor4)
end

local rect4 = display.newRect(rect3.x+largo1*math.cos(math.rad(angulo3)) , rect3.y-largo1*math.sin(math.rad(angulo3)),largo2 ,ancho)
rect4:setFillColor(0,0,0,0) -- Naranja
rect4.strokeWidth = 0
rect4:setStrokeColor(0, 0, 0) -- Negro
rect4.anchorX=0 ; rect1.anchorY=0.5
rect4.rotation = -angulo4


rect4:addEventListener("touch", SelectMotor4)
-- Dibujar círculos en los extremos
local circle30 = display.newCircle(rect3.x+largo1*math.cos(math.rad(angulo3)) , rect3.y-largo1*math.sin(math.rad(angulo3)), 10)
circle30:setFillColor(1, 1, 0) -- Amarillo
circle30.strokeWidth = 2
circle30:setStrokeColor(0, 0, 0) -- Negro




end

dibujar()