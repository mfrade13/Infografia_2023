local composer = require("composer")

-- Crear el grupo "mainGroup"
local mainGroup = display.newGroup()

-- Crear el grupo "menuGroup"
local menuGroup = display.newGroup()
-- Definir las funciones de los eventos de las imágenes
local function imageTapped(event)
  if event.phase == "ended" then
    -- Ocultar todos los elementos de la escena "main"   
    local imageName = event.target.name
    mainGroup.isVisible = false
    -- Transicionar a la escena "menu"
    composer.gotoScene("menu", { effect = "fade", time = 500, params = { imageName = imageName } })
    pokedex.isVisible = true
    searchBox.isVisible = true 
  end
end

-- Crear las imágenes y asociar eventos dentro del grupo "mainGroup"
local fondo = display.newRect(mainGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
fondo:setFillColor(0.9, 0.3, 0.3)
local images = {}
local generationTexts = {"Primera generación", "Segunda generación", "Tercera generación", "Cuarta generación", "Quinta generación", "Sexta generación", "Séptima generación", "Octava generación", "Novena generación"}
local imageWidth = display.contentWidth / 4 -- Ancho de cada imagen
local imageHeight = display.contentHeight / 11 -- Alto de cada imagen
local startX = (display.contentWidth - imageWidth * 2) / 2 -- Posición inicial en X

local spacingX = imageWidth * 2.5 -- Espaciado horizontal entre imágenes
local spacingY = (display.contentHeight - (imageHeight * 4)) / 5 -- Espaciado vertical entre imágenes

for i = 1, 9 do
  local image = display.newImageRect(mainGroup, "../img/imagen_" .. i .. ".png", imageWidth, imageHeight)
  local x = startX + ((i - 1) % 2) * spacingX
  local y = math.floor((i - 1) / 2) * (imageHeight + spacingY) + imageHeight / 2
  image.x = x
  image.y = y
  image.index = i
  image.name = "Imagen " .. i
  image:addEventListener("touch", imageTapped)
  images[i] = image
  
  local generationText = display.newText(mainGroup, generationTexts[i], x, y + imageHeight / 2 + 10, native.systemFont, 12)
  generationText:setFillColor(1, 1, 1)
end

-- Ocultar el grupo "mainGroup" al iniciar la escena
local function hideMainGroup()
  mainGroup.isVisible = false
end

-- Agregar la función "hideMainGroup" a la escena "main" en el evento "hide"
local scene = composer.newScene("main")
function scene:hide(event)
  if event.phase == "did" then
    hideMainGroup()
  end
end
scene:addEventListener("hide", scene)

-- Mostrar el grupo "mainGroup" al iniciar la escena
function scene:show(event)
  if event.phase == "did" then
    mainGroup.isVisible = true
  end
end
scene:addEventListener("show", scene)

-- Transicionar a la escena "main"
composer.gotoScene("main")
