-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here-----------
local composer = require "composer"
CW = display.contentWidth
CH = display.contentHeight
assetsPath = "/Assets/"
poke_api = "https://pokeapi.co/api/v2/pokemon/"
poke_api_2 = "https://pokeapi.co/api/v2/pokemon-species/"
font = "/Assets/Fonts/pokemon_fire_red"


composer.gotoScene("splashScreen", "fade", 1250)