-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local physics = require "physics"
-- Your code here

local CW = display.contentWidth
local CH = display.contentHeight

local grupoEscena = display.newGroup()
local grupoFondo = display.newGroup()
local grupoMedio = display.newGroup()
local grupoInterfaz = display.newGroup()

physics.start()
physics.setDrawMode("hybrid")

grupoEscena:insert(grupoFondo)
grupoEscena:insert(grupoInterfaz)

local fondo = display.newImageRect(grupoFondo, "1.jpg", CW, CH) -- mover con el personaje
fondo.x = CW/2; fondo.y = CH/2

local fondo2 = display.newImageRect(grupoFondo, "1.jpg", CW, CH) -- mover con el personaje
fondo2.x = CW/2 - CW; fondo2.y = CH/2

local velocidad = 15
local escenario = 1

local options = {
    width = 300,
    height = 300,
    numFrames = 8
}
local options_special = {
    width = 1599/3,  -- 533
    height = 600/2,  -- 300
    numFrames = 6
}

local personaje_sprite = graphics.newImageSheet("avanzaD.png", options )
local personaje_special_sprite = graphics.newImageSheet("special.png", options_special)
local personaje_caminar_izquierda = graphics.newImageSheet("avanzaL.png", options)

local sequence = {
    {
        name = "correr",
        start = 1,
        count = 8,
       -- frames = {4,5,6,7,8,1,2,3,3,3,3,4,4,4,5 },
        time = 600,  --  1 segundo cada 12 cuadros   8/12  2/3 
        loopCount = 0,
        sheet = personaje_sprite
    },
    {
        name = "atacar",
        time = 1333,
        frames = {1,3,5,6},
        sheet = personaje_special_sprite,
        loopCount = 1
    },{
        name = "golpe",
        frames = {2,4,6},
        loopCount = 1,
        time = 1000,
        sheet = personaje_special_sprite

    },
    {
        name = "left_move",
        -- start = 4,
        -- count = 8,
        frames = {4,3,2,1,8,7,6,5},
        time = 600,
        sheet = personaje_caminar_izquierda

    }

}
local personaje = display.newSprite(grupoEscena,personaje_sprite, sequence)
personaje.x = CW/2; personaje.y = CH/2
personaje:scale(0.7, 0.7)
personaje:setSequence("left_move")
personaje:play()
local personaje_body = {
    halfWidth = 300 *0.3/ 2,
    halfHeight =300 *0.4 / 2,
    x=0,
    y=10,
    angle=00
}
physics.addBody(personaje, "dynami",{box=personaje_body, bounce = 1})
print(personaje.sequence, personaje.frame)


local piso = display.newRect(grupoFondo, CW/2, CH * 0.8, CW, 30)
piso:setFillColor(0,1,0,0)
physics.addBody(piso, "static")

local boton_atacar = display.newImageRect(grupoInterfaz,"atacar.png", 100,100)
boton_atacar.x = CW/4; boton_atacar.y = 200
boton_atacar.animacion = "atacar"

local boton_golpe = display.newImageRect(grupoInterfaz,"atacar.png", 100,100)
boton_golpe.x = CW*3/4; boton_golpe.y = boton_atacar.y
boton_golpe.animacion = "golpe"

local padD = display.newImageRect(grupoInterfaz, "pad.png", 150,150)
padD.x = boton_golpe.x; padD.y = CH/4*3 

local estaAtacando = false

function caminar(e)
    if (e.phase == "moved") then
        personaje:translate(1, 0 )
    end
    return true
end


function volverACmaniar()
    personaje:setSequence("correr")
    personaje:play()
    estaAtacando = false
end

function animar(e)
    if e.phase == "ended" then
        if estaAtacando == false then
            estaAtacando = true
            local target = e.target
            print("Propiedad de animacion",  e.target.animacion)
            print(personaje.sequence)
            personaje:setSequence(e.target.animacion )
            personaje:play()
            timer.performWithDelay(2000, volverACmaniar)
        else
            print("ya esta atacando y debo esperar a que termine para ejectura de nuevo")
        end  
    end
    return true
end

function onKeyEvent(event)
    --print(event.phase, event.keyName)
    if event.keyName == "right" then
        if personaje.isPlaying == false then 
            personaje:setSequence("correr")
            personaje:play()
        end
        if personaje.sequence ~= "correr" then
            personaje:setSequence("correr")
        end
        if event.phase == "down" then
            personaje:translate(velocidad, 0 )
            --grupoFondo:translate(-1*velocidad,0)
        end
        print(personaje.x)
    elseif event.keyName == "left" then
        if personaje.isPlaying == false then 
            personaje:setSequence("left_move")
            personaje:play()
        end
        if personaje.sequence ~= "left_move" then
            personaje:setSequence("left_move")
        end
        if event.phase == "down" then
            personaje:translate(-1*velocidad, 0 )
            --grupoFondo:translate(velocidad,0)
            print(personaje.x)
        end
    end

end

function nuevaPantalla()
    personaje.x = 20
    transition.to(grupoEscena,{alpha = 1, time =1000, delay=500})
    local paint = {
        type = "image",
        filename = "5.jpg"
    }
    fondo.fill = paint
end

function cambiarPantalla()
    if escenario == 1 then
        transition.to(grupoEscena, {alpha = 0.1, time = 1500, delay = 500, onComplete=nuevaPantalla})
        escenario = 2
    end
end

function camara(e)
    -- if personaje.x > CW then -- verificacion si nos salimos de pantalla
    --     print("Nos salimos de pantalla")
    --     cambiarPantalla() -- mover la pantalla cuando el personaje excede el limite y desplegar un escenario nuevo con un efecto.
    -- end

    grupoEscena.x = -personaje.x  + CW/2 --defase 
    grupoInterfaz.x = -grupoEscena.x
end

Runtime:addEventListener("enterFrame", camara)

Runtime:addEventListener("key", onKeyEvent)
boton_atacar:addEventListener("touch", animar)
boton_golpe:addEventListener("touch", animar)

padD:addEventListener("touch", caminar)
