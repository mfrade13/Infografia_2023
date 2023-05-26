-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
-- Detalles de un videojuejo
-- Controles para personajes o el juego como tal
-- Vidas -- no jugable
-- Jugador/personaje -- jugable
-- Menu, escenas del juego
-- Objetivos/logros
-- funcionalidades de personajes
-- puntaje -- no jugable
-- obstaculos, antagonistas, enemigos -- jugable
-- botones para comenzar,opciones del juego, salir,
-- titulo del juego,
-- fondo, escenas  -- no jugable,

-- 2 capas,  jugables y no jugable

local CW = display.contentWidth
local CH = display.contentHeight

local pathAssets = "PrimerParcial/"
local ejectuarTransicion = true

local grupoFondo = display.newGroup()
local grupoJugable = display.newGroup()
local grupoNoJugable = display.newGroup()

local fondo = display.newImageRect("PrimerParcial/5.jpg",CW, CH )
fondo.x, fondo.y = CW/2, CH/2

grupoFondo:insert(fondo)
local transicionParpadeo

local obstaculo = display.newImageRect(grupoJugable, pathAssets.."hoja.png", 100, 100)
obstaculo.x, obstaculo.y = math.random(100, CW-100), math.random(100, CH-100) 
--obstaculo.x = CW/2; obstaculo.y = CH/8

local titulo = display.newText(  "JUEGO", CW/2, CH/8, "arial 2 black", 30 )
titulo:setFillColor( 233/255, 180/255, 0 )
grupoJugable:insert(2, titulo)


local personaje = display.newImageRect( grupoJugable, pathAssets.. "personaje.png", 560 ,400)
personaje.x, personaje.y = CW/2, CH/2
personaje:scale( 0.5, 0.5 )
personaje.anchorX = 0.5; personaje.anchorY = 0.5

local valorPuntaje = 0
local puntaje = display.newText(grupoNoJugable, "SCORE: 0", 0, 50, "arial black", 25)
puntaje.anchorX = 0
--grupoJugable:insert(personaje)

local vidaJugador = display.newText(grupoJugable, "LIFE: 100%", CW, 50, "arial black", 25)
vidaJugador.anchorX = 1

-- grupoFondo.alpha = 0.4
-- grupoJugable.isVisible = true

local botonPlay = display.newImage(grupoNoJugable, pathAssets.."play.png", CW - 100, vidaJugador.y + 100)
botonPlay.x, botonPlay.y = CW - 100, vidaJugador.y + 100
botonPlay.xScale = 0.3 ; botonPlay.yScale = 0.3

function aumentarPuntaje()
    valorPuntaje = valorPuntaje + 10
    puntaje.text = "SCORE: " .. valorPuntaje
end

function destruir( e)
    if e.phase == "ended" then
        aumentarPuntaje()
    end
    return true
end

function botonPlay:touch(e)
    if e.phase == "ended" then
        --self.isVisible = false
        if ejectuarTransicion then
            ejectuarTransicion = false
            transition.pause( personaje )
            print("Poscion del touch", e.x, e.y )
            print("posicion del boton", self.x, self.y )
        else
            ejectuarTransicion = true
            transition.resume(personaje)
            print( "Resumir transciones." )
        end

    end
    return true
end

obstaculo:addEventListener("touch", destruir)
botonPlay:addEventListener("touch")

print(personaje.x, personaje.y)
-- desfase 15, 17
personaje:translate( 15, 17 )
print(personaje.x, personaje.y)


local cuadrado = display.newRect(CW/4, CH/4, 60,60)
cuadrado:setFillColor( 1,0,0 )
cuadrado:rotate( 60 )
cuadrado.anchorX = 0
cuadrado:scale( 2, 3 )
print("Ancho del cuadrado", cuadrado.contentWidth, cuadrado.height )

local vertices = { 0,0, 0,180, 120,180, 120,0 } -- 2, 3
local poligono = display.newPolygon( cuadrado.x, cuadrado.y + 100, vertices )
poligono:setFillColor( 0, 0,1 )
poligono.rotation = 60

local x,y =60,0

local x1 = math.cos( math.rad( 60) ) * x - math.sin( math.rad( 60) ) * y
local y1 = math.sin( math.rad( 60) ) * x + math.cos( math.rad( 60) ) * y


print(x1, y1, math.cos(math.rad( 60)))

local vertices2 = {0,0, -51, 30, -22, 82, 30, 51}

local poligono2 = display.newPolygon( cuadrado.x, cuadrado.y , vertices2 )
poligono2:setFillColor( 0, 1, 0, 0.7 )
print( poligono.rotation )


print(grupoJugable.x, grupoJugable.y, grupoJugable.rotation)

-- grupoJugable.rotation =30

-- grupoJugable:scale(0.3, 0.3)

function moverPersonaje(obj)
    print("Se esta ejecutando el onComplete de la primera transicion")
    transition.to(obj, {time= 2000, y = CH/2, x= CW/2, onComplete=moverPersonaje2, tag="movimiento"})
end

function moverPersonaje2()
    print("Segunda transicion")
    transition.to(personaje, {time= 2000, x=CW, y=CH, tag = "movimiento"}) --onPause = deteniendoAlPersonaje})
end

function parpadeo()
    personaje.alpha = 0.2
end

function deteniendoAlPersonaje()
    personaje.detenido = true
    print( "se ha detenido la transicion" )
end


transition.to(personaje, {time = 2000,  x=0, y= CH, onComplete=moverPersonaje, onPause=deteniendoAlPersonaje, tag="movimiento" } )
transicionParpadeo = transition.to(personaje, {time= 200, alpha = 1, iterations = 15, onStart=parpadeo})
--transition.to(personaje, {time= 200, alpha = 1, delay = 3000})
transition.to(titulo, { time =1000, size=40, iterations=10, tag= "movimiento" })
