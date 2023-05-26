local composer = require("composer")
local scene = composer.newScene("menu")
local cw = display.contentWidth
local ch = display.contentHeight
pokedex = display.newGroup()
searchBox = native.newTextField(cw/2, ch/4, cw/2, 40)
function scene:create(event)
  local fondo = display.newRect(pokedex, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
  fondo:setFillColor(0.9, 0.3, 0.3)
  local sceneGroup = self.view
  local json = require("json")
  local network = require("network")
  local display = require("display")
  local native = require("native")

  local imageName = event.params.imageName
  print(imageName)
  local currentPokemonNumber = 1
  local pokemonImage
  local nombreTxt, alturaTxt, pesoTxt

  local volteado = true

  local function fetchPokemonData(pokemonNumber)
    local url = "https://pokeapi.co/api/v2/pokemon/" .. pokemonNumber
    network.request(url, "GET", function(event)
      if (event.isError) then
        print("Error al obtener los datos del Pokémon.")
      else
        local responseData = json.decode(event.response)
        local pokemonName = responseData.name
        local pokemonHeight = responseData.height
        local pokemonWeight = responseData.weight
        local imageURL = responseData.sprites.front_default
        local imageBackURL = responseData.sprites.back_default
        local abilities = responseData.abilities
        local types = responseData.types
        local experience = responseData.base_experience

        -- Borra los datos y la imagen del Pokémon anterior
        if pokemonImage then
          display.remove(pokemonImage)
          pokemonImage = nil
        end
        if nombreTxt then
          display.remove(nombreTxt)
          nombreTxt = nil
        end
        if alturaTxt then
          display.remove(alturaTxt)
          alturaTxt = nil
        end
        if pesoTxt then
          display.remove(pesoTxt)
          pesoTxt = nil
        end

        -- Muestra los datos del Pokémon
        nombreTxt = display.newText(pokedex, "Nombre: " .. pokemonName, cw/2 , ch/2+60, "arial Black", 15)
        alturaTxt = display.newText(pokedex, "Altura: " .. pokemonHeight, cw/2 , ch/2+80, "arial Black", 15)
        pesoTxt = display.newText(pokedex, "Peso: " .. pokemonWeight, cw/2 , ch/2+100, "arial Black", 15)
        abilityTxt = display.newText(pokedex, "Habilidad: " .. abilities[1].ability.name, cw/2 , ch/2+60, "arial Black", 15)
        typeTxt = display.newText(pokedex, "Tipo: " .. types[1].type.name, cw/2 , ch/2+80, "arial Black", 15)
        experienceTxt = display.newText(pokedex, "Experiencia: " .. experience, cw/2 , ch/2+100, "arial Black", 15)
        abilityTxt.isVisible = false
        typeTxt.isVisible = false
        experienceTxt.isVisible = false

        -- Carga y muestra la imagen del Pokémon
        -- Fill 
        if volteado == true then
          display.loadRemoteImage(imageURL, "GET", function(event)
            if not event.isError then
              pokemonImage = event.target
              pokemonImage.x = display.contentCenterX
              pokemonImage.y = display.contentCenterY
              pokedex:insert(pokemonImage)
            else
              print("Error al cargar la imagen del Pokémon.")
            end
          end, "pokemon_image.png", system.TemporaryDirectory)
        else
          display.loadRemoteImage(imageBackURL, "GET", function(event)
            if not event.isError then
              pokemonImage = event.target
              pokemonImage.x = display.contentCenterX
              pokemonImage.y = display.contentCenterY
              pokedex:insert(pokemonImage)
            else
              print("Error al cargar la imagen del Pokémon.")
            end
          end, "pokemon_image.png", system.TemporaryDirectory)
        end
        
      end
    end)
  end

  local function searchPokemon(event)
    if (event.phase == "ended" or event.phase == "submitted") then
      local pokemonNumber = tonumber(searchBox.text)
      if pokemonNumber then
        fetchPokemonData(pokemonNumber)
        currentPokemonNumber = pokemonNumber
      else
        print("Ingresa un número válido de Pokémon.")
      end
      native.setKeyboardFocus(nil)
    end
  end

  local function showNextPokemon()
    currentPokemonNumber = currentPokemonNumber + 1
    fetchPokemonData(currentPokemonNumber)
    return true 
  end

  local function showPreviousPokemon()
    if currentPokemonNumber > 1 then
      currentPokemonNumber = currentPokemonNumber - 1
      fetchPokemonData(currentPokemonNumber)
      return true
    end
  end

  searchBox.align = "center"
  searchBox.inputType = "number"
  searchBox:addEventListener("userInput", searchPokemon)
  local enterButton = display.newText(pokedex, "Enter", cw/2 + 120, ch/4, native.systemFont, 20)
  enterButton:setFillColor(0.8, 0.8, 0.8)

  local function enterButtonTapped(event)
    if (event.phase == "ended") then
      local pokemonNumber = tonumber(searchBox.text)
      if pokemonNumber then
        fetchPokemonData(pokemonNumber)
        currentPokemonNumber = pokemonNumber
      else
        print("Ingresa un número válido de Pokémon.")
      end
      native.setKeyboardFocus(nil)
      return true 
    end
  end
  enterButton:addEventListener("touch", enterButtonTapped)

  local leftButton = display.newText(pokedex, "<", display.contentCenterX - 100, display.contentHeight - 50, native.systemFont, 36)
  leftButton:setFillColor(1, 1, 1)
  leftButton:addEventListener("tap", showPreviousPokemon)

  local rightButton = display.newText(pokedex, ">", display.contentCenterX + 100, display.contentHeight - 50, native.systemFont, 36)
  rightButton:setFillColor(1, 1, 1)
  rightButton:addEventListener("tap", showNextPokemon)

  local downArrow = display.newImageRect(pokedex, "../img/down_arrow.png", 10, 10)
  downArrow.x = display.contentCenterX
  downArrow.y = ch/2+120
  local upArrow = display.newImageRect(pokedex, "../img/down_arrow.png", 10, 10)
  upArrow.x = display.contentCenterX
  upArrow.y = ch/2+45
  upArrow.rotation = 180
  upArrow.isVisible = false

  local rect1 = display.newRect(pokedex, display.contentCenterX - 10, display.contentHeight -50, 25,10)
  rect1:setFillColor( 1,0,0 )
  local rect2 = display.newRect(pokedex, display.contentCenterX + 15, display.contentHeight -50, 25,10)
  rect2:setFillColor( 0,0,1 )

  local function downArrowTapped()
    abilityTxt.isVisible = true
    typeTxt.isVisible = true
    experienceTxt.isVisible = true
    nombreTxt.isVisible = false
    pesoTxt.isVisible = false
    alturaTxt.isVisible = false
    upArrow.isVisible = true
    downArrow.isVisible = false
  end

  local function upArrowTapped()
    abilityTxt.isVisible = false
    typeTxt.isVisible = false
    experienceTxt.isVisible = false
    nombreTxt.isVisible = true
    pesoTxt.isVisible = true
    alturaTxt.isVisible = true
    upArrow.isVisible = false
    downArrow.isVisible = true
  end

  downArrow:addEventListener("tap", downArrowTapped)
  upArrow:addEventListener("tap", upArrowTapped)

  local function rotar()
    volteado = not volteado
    fetchPokemonData(currentPokemonNumber)
  end

  local cuadradoAuxiliar = display.newRect(pokedex, cw/2, ch/2, 50, 50)
  cuadradoAuxiliar:setFillColor(255, 255, 255, 0.01)
  cuadradoAuxiliar:addEventListener("tap", rotar)

  local volverArrow = display.newImageRect( pokedex,"../img/down_arrow.png", 25,25 )
  volverArrow.x = 30
  volverArrow.y = 30
  volverArrow.rotation = 90

  local function volver()
    composer.gotoScene("main", { effect = "fade", time = 500 })
    pokedex.isVisible = false
    searchBox.isVisible = false
  end

  local logo = display.newImageRect( pokedex,"../img/logo.png",200, 50 )
  logo.x = cw/2
  logo.y = 30
  volverArrow:addEventListener( "tap", volver )
  -- Ingresa el número del Pokémon inicial que deseas mostrar
  local initialPokemonNumber = 1
  fetchPokemonData(initialPokemonNumber)
end

function scene:show(event)
end

function scene:hide(event)
end

function scene:destroy(event)
end 

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene 

