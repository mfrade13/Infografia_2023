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

local grupoFondo = display.newGroup()
local grupoJugable = display.newGroup()
local grupoNoJugable = display.newGroup()

local fondo = display.newImageRect("PrimerParcial/5.jpg",CW, CH )
fondo.x, fondo.y = CW/2, CH/2

grupoFondo:insert(fondo)

local obstaculo = display.newImageRect(grupoJugable, pathAssets.."hoja.png", 100, 100)
obstaculo.x, obstaculo.y = math.random(100, CW-100), math.random(100, CH-100) 
--obstaculo.x = CW/2; obstaculo.y = CH/8

local titulo = display.newText(  "JUEGO", CW/2, CH/8, "arial black", 30 )
titulo:setFillColor( 233/255, 180/255, 0 )
grupoJugable:insert(2, titulo)


local personaje = display.newImageRect( grupoJugable, pathAssets.. "personaje.png", 560/2 ,400/2)
personaje.x, personaje.y = CW/2, CH/2

local valorPuntaje = 0
local puntaje = display.newText(grupoNoJugable, "SCORE: 0", 0, 50, "arial black", 25)
puntaje.anchorX = 0
--grupoJugable:insert(personaje)

local vidaJugador = display.newText(grupoJugable, "LIFE: 100%", CW, 50, "arial black", 25)
vidaJugador.anchorX = 1

-- grupoFondo.alpha = 0.4
-- grupoJugable.isVisible = true

local botonPlay = display.newImageRect(grupoNoJugable, pathAssets.."play.png", 100,100)
botonPlay.x, botonPlay.y = CW - 100, vidaJugador.y + 100

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
        self.isVisible = false

    end
    return true
end

obstaculo:addEventListener("touch", destruir)
botonPlay:addEventListener("touch")

