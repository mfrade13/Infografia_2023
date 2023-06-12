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
personaje.x = CW/2; personaje.y = CH * 0.4
personaje:scale(0.7, 0.7)
personaje:setSequence("left_move")
personaje:play()
personaje.name = "Cazador"
local personaje_body = {
    halfWidth = 300 *0.3/ 2,
    halfHeight =300 *0.4 / 2,
    x=0,
    y=10,
    angle=00
}


physics.addBody(personaje, "dynamic",{radius = 70, bounce = 0.2, friction = 0.0 })
print(personaje.sequence, personaje.frame)
personaje.isFixedRotation = true
--personaje.gravityScale = 0
local piso = display.newRect(grupoFondo, 0, CH * 0.9, CW*2, 30)
piso:setFillColor(0,1,0,0)
piso.rotation = 0
physics.addBody(piso, "static", {friction = 1})
piso.name = "piso"

local paredIzq = display.newRect(grupoFondo, -CW, CH/2, 20, CH  )
physics.addBody(paredIzq, "static")
paredIzq.name = "Soy la pared izquierda"


local esfera = display.newCircle(grupoEscena, personaje.x, CH/2 +100, 20)
physics.addBody(esfera, "dynamic", {radius = 20, density = 3.12, bounce = 0.6 })
esfera.name = "esfera"

print(physics.getGravity())
--physics.setGravity(-1, 1)

local boton_atacar = display.newImageRect(grupoInterfaz,"atacar.png", 100,100)
boton_atacar.x = CW/4; boton_atacar.y = 200
boton_atacar.animacion = "atacar"

local boton_golpe = display.newImageRect(grupoInterfaz,"atacar.png", 100,100)
boton_golpe.x = CW*3/4; boton_golpe.y = boton_atacar.y
boton_golpe.animacion = "golpe"

local padD = display.newImageRect(grupoInterfaz, "pad.png", 150,150)
padD.x = boton_golpe.x; padD.y = CH/4*3 

local estaAtacando = false
local enemigos = {}
contador = 1
function crearEnemigos()
    enemigos[contador] = display.newCircle(grupoEscena, math.random(-CW/2, CW), CH/2, 20)
    enemigos[contador]:setFillColor(1,0,0)
    physics.addBody(enemigos[contador], "dynamic", {radius = 20, bounce = 0.5 })
    
    enemigos[contador].name= "enemigo"
    contador = contador + 1
end



function caminar(e)
    if (e.phase == "moved") then
        personaje:translate(1, 0 )
    end
    return true
end


function volverACmaniar()
    personaje.xScale = 0.7; personaje.yScale=0.7
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
            --print(personaje.sequence)
            --personaje:scale(1,1)
            personaje.xScale = 1; personaje.yScale=1
            personaje:setSequence(e.target.animacion )
            personaje:play()
            if (e.target.animacion ~= "golpe") then
                personaje:applyLinearImpulse(0, -2, personaje.x, personaje.y)
            else
                personaje.bodyType = "dynamic"
            end
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
            --personaje:translate(velocidad, 0 )
            personaje:applyLinearImpulse(0.5,0)
            --print("velocidad de movimiento", personaje:getLinearVelocity())
            --grupoFondo:translate(-1*velocidad,0)
        end
        --print(personaje.x)
    elseif event.keyName == "left" then
        if personaje.isPlaying == false then 
            personaje:setSequence("left_move")
            personaje:play()
        end
        if personaje.sequence ~= "left_move" then
            personaje:setSequence("left_move")
        end
        if event.phase == "down" then
         --   personaje:translate(-1*velocidad, 0 )
            personaje:applyLinearImpulse(-0.5,0)
            --grupoFondo:translate(velocidad,0)
            --print(personaje.x)
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

function checkCollision(self, event)
    -- print(event.target.name)
    -- print(event.other.name)
    if event.other.name == "enemigo" then
--        event.other.isVisible=false   # No basta con hacerlos invisibles
        --if event.target.sequence == "golpe" then # secuencias de animacion no son las mejores maneras de registra eventos de colision
        if estaAtacando == true then
            if self.y < event.other.y then
                print("Estoy encima del enemigo")
                display.remove(event.other)
            else
                print("estoy debajo")
            end
        end
    elseif event.other.name == "esfera" then
        print("colision con la esfera")
        timer.performWithDelay(500, function ()
            event.other.bodyType = "dynamic"
            end
        )
    end

end

function checkCollision2(self, event)
    print(event.target.name)
    print(event.other.name)
end

personaje.collision = checkCollision
personaje:addEventListener("collision")

paredIzq.collision = checkCollision2
paredIzq:addEventListener("collision")


Runtime:addEventListener("enterFrame", camara)

timer.performWithDelay(2000, crearEnemigos, 30)

Runtime:addEventListener("key", onKeyEvent)
boton_atacar:addEventListener("touch", animar)
boton_golpe:addEventListener("touch", animar)

padD:addEventListener("touch", caminar)
