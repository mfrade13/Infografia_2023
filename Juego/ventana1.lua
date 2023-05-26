local composer = require("composer")
local scene = composer.newScene()

local json = require("json")
local idPokemon = 1
local imagenPokemon

local CW = display.contentWidth
local CH = display.contentHeight
local pathAssets = "imagenes/"

local fondoPlantilla
local fondoMenu
local botonRegresar
local siguiente
local anterior
local fondoPokemon
local fondoPokemonDetalles
local fondoPokemonDetalles1
local nombrePokemon
local fondoPokemonTexto1
local fondoPokemonTexto
----------
local musica

musica= audio.loadStream(pathAssets.."pokemon_theme_song_mp3_15917.mp3")
audio.play(musica, { loops = -1 })

--volver
function irMenu(event)
    if event.phase == "ended" then
        composer.gotoScene("menu", "fade")
        
    end
    return true
end

-- Obtener una lista de habilidades separadas por coma
local function obtenerListaHabilidades(abilities)
    local listaHabilidades = {}
    for i = 1, #abilities do
        table.insert(listaHabilidades, abilities[i].ability.name)
    end
    return table.concat(listaHabilidades, ", ")
end

-- Obtener una lista de tipos separados por coma
local function obtenerListaTipos(types)
    local listaTipos = {}
    for i = 1, #types do
        table.insert(listaTipos, types[i].type.name)
    end
    return table.concat(listaTipos, ", ")
end

-- Obtener las estadísticas base en forma de cadena
local function obtenerEstadisticasBase(stats)
    local estadisticasBase = {}
    for i = 1, #stats do
        local stat = stats[i]
        local nombreStat = stat.stat.name
        local valorStat = stat.base_stat
        table.insert(estadisticasBase, nombreStat .. ": " .. valorStat)
    end
    return table.concat(estadisticasBase, ", ")
end

-- Obtener una lista de movimientos separados por coma
local function obtenerListaMovimientos(moves)
    local listaMovimientos = {}
    for i = 1, #moves do
        table.insert(listaMovimientos, moves[i].move.name)
    end
    return table.concat(listaMovimientos, ", ")
end

function scene:create(event)
    local sceneGroup = self.view
    --Fondo principla de ventana 1
    fondoMenu = display.newImageRect(sceneGroup, pathAssets .. "fondoVentana1.jpg", CW, CH)
    fondoMenu.x, fondoMenu.y = CW / 2, CH / 2
    --boton regresar
    botonRegresar = display.newImageRect(sceneGroup, pathAssets .. "Boton_Regresar1.png", 160, 70)
    botonRegresar.x, botonRegresar.y = CW / 1.22, CH / 1.2
    --boton siguiente
    siguiente = display.newImageRect(sceneGroup, pathAssets .. "siguiente1.png", 50, 50)
    siguiente.x, siguiente.y = CW / 1.15, CH / 6.7
    --boton anterior
    anterior = display.newImageRect(sceneGroup, pathAssets .. "anterior1.png", 50, 50)
    anterior.x, anterior.y = CW / 1.4, CH / 6.7
    --fondo atras del pokemon
    fondoPokemon = display.newRect(sceneGroup, CW / 3.5, CH / 3, 1500 / 6, 1000 / 6)
    fondoPokemon:setFillColor(1,1,1)
    fondoPokemon.alpha = 0.4
    --fondo atras de la informacion del pokemon
    fondoPokemonTexto = display.newRect(sceneGroup, CW / 2.98, CH / 1.2, 300, 85 )
    fondoPokemonTexto:setFillColor(1,1,1)
    fondoPokemonTexto.alpha = 0.4
    --fondo atras de la informacion del pokemon
    fondoPokemonTexto1 = display.newRect(sceneGroup, CW / 1.29, CH / 1.9, 195, 85 )
    fondoPokemonTexto1:setFillColor(1,1,1)
    fondoPokemonTexto1.alpha = 0.4
    --texto del pokemon 
    fondoPokemonDetalles = display.newText(sceneGroup, "", CW / 2.98, CH / 1.2, 280, 0, "Comic Sans MS", 14)
    fondoPokemonDetalles:setFillColor(0,0,0)
   --texto 2 del pokemon 
    fondoPokemonDetalles1 = display.newText(sceneGroup, "", CW / 1.24, CH / 1.9, 195, 0, "Comic Sans MS", 14)
    fondoPokemonDetalles1:setFillColor(0,0,0)

    nombrePokemon = display.newText(sceneGroup, "", CW / 3.5, CH / 1.55, "Times New Roman", 25)
    nombrePokemon:setFillColor(1, 1, 1)

    local function manejoRespuesta(event)
        if (event.isError) then
            print("Network error: ", event.response)
        else
            local datos = json.decode(event.response)
            nombrePokemon.text = datos.name

            if imagenPokemon then
                display.remove(imagenPokemon)
                imagenPokemon = nil
            end

            if datos.sprites and datos.sprites.front_default then
                display.loadRemoteImage(
                    datos.sprites.front_default,
                    "GET",
                    function(event)
                        if not event.isError then
                            imagenPokemon = event.target
                            imagenPokemon.x = CW / 3.5
                            imagenPokemon.y = CH / 3
                            imagenPokemon.width = 170
                            imagenPokemon.height = 170
                            sceneGroup:insert(imagenPokemon)
                        else
                            print("Error loading image:", event.response)
                        end
                    end,
                    "tempPokemon.png",
                    system.TemporaryDirectory
                )
            else
                print("No sprite data available for the Pokémon")
            end

            if datos.abilities then
                local habilidades = obtenerListaHabilidades(datos.abilities)
                fondoPokemonDetalles.text = "Habilidades: " .. habilidades
            end

            if datos.types then
                local tipos = obtenerListaTipos(datos.types)
                fondoPokemonDetalles.text = fondoPokemonDetalles.text .. "\nTipos: " .. tipos
            end

            if datos.stats then
                local estadisticasBase = obtenerEstadisticasBase(datos.stats)
                fondoPokemonDetalles.text = fondoPokemonDetalles.text .. "\nEstadísticas Base: " .. estadisticasBase
            end

            if datos.moves then
                local movimientos = obtenerListaMovimientos(datos.moves)
                fondoPokemonDetalles1.text = "Movimientos: " .. movimientos
            end

            local detalles1 = "ID: " .. datos.id .. "\n"
            detalles1 = detalles1 .. "Peso: " .. datos.weight .. "\n"
            detalles1 = detalles1 .. "Altura: " .. datos.height .. "\n"
            detalles1 = detalles1 .. "Experiencia Base: " .. datos.base_experience

            fondoPokemonDetalles1.text = detalles1
        end
    end

     function cargarPokemon()
        local url = "https://pokeapi.co/api/v2/pokemon/" .. idPokemon
        network.request(url, "GET", manejoRespuesta)
    end

    siguiente:addEventListener("tap", function()
        idPokemon = idPokemon + 1
        cargarPokemon()
    end)

    anterior:addEventListener("tap", function()
        idPokemon = idPokemon - 1
        if idPokemon < 1 then
            idPokemon = 1
        end
        cargarPokemon()
    end)
    cargarPokemon()
    
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
    elseif (phase == "did") then
        cargarPokemon()
        audio.play(musica, { loops = -1 })
        botonRegresar:addEventListener("touch",irMenu)
        
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        
        botonRegresar:removeEventListener("touch", irMenu)  -- Utilizar la función irMenu en lugar de botonRegresar
        anterior:removeEventListener("touch", anterior)
        siguiente:removeEventListener("touch", siguiente)
        fondoPokemonDetalles.text = ""
        fondoPokemonDetalles1.text = ""
         idPokemon = 1
         display.remove(imagenPokemon)
        imagenPokemon = nil
        audio.stop()
        
        
    elseif (phase == "did") then
        
    end
end

function scene:destroy(event)
    local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene