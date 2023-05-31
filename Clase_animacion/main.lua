-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local CW = display.contentWidth
local CH = display.contentHeight

local fondo = display.newImageRect("1.jpg", CW, CH)
fondo.x = CW/2; fondo.y = CH/2

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

    }

}
local personaje = display.newSprite(personaje_sprite, sequence)
personaje.x = CW/2; personaje.y = CH/2
personaje:scale(0.7, 0.7)
personaje:setSequence("correr")
personaje:play()
print(personaje.sequence, personaje.frame)

local boton_atacar = display.newImageRect("atacar.png", 100,100)
boton_atacar.x = CW/4; boton_atacar.y = 200
boton_atacar.animacion = "atacar"

local boton_golpe = display.newImageRect("atacar.png", 100,100)
boton_golpe.x = CW*3/4; boton_golpe.y = boton_atacar.y
boton_golpe.animacion = "golpe"

local padD = display.newImageRect("pad.png", 150,150)
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

boton_atacar:addEventListener("touch", animar)
boton_golpe:addEventListener("touch", animar)

padD:addEventListener("touch", caminar)
