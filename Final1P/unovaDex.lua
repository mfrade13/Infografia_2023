local composer = require "composer"
local scene = composer.newScene()
local json = require "json"
local network = require "network"
local widget = require("widget")

local current_pkmn = 494
local max_pkmn = 649
local sceneGroup

local fondo
local sprite
local sprite_url

local id_txt
local name_txt
local weight_txt
local height_txt
local desc_txt

local scrollView
local next_btn
local prev_btn
local back_btn
local textField

local function back_btn_touch(e)
    print("Back Btn Touch")
    composer.gotoScene("menu", "fade", 100)
end

local function requestSprite(e)

    local response = e.response
    print("Filename: "..response.filename)
    print("BaseDirectory: "..tostring(response.baseDirectory))
    display.remove(sprite)
    sprite = nil
    sprite = display.newImageRect(e.response.filename, e.response.baseDirectory, 300, 300)
    sprite.x, sprite.y = (CW/30), (CH/22)
    sprite.anchorX, sprite.anchorY = 0 , 0
    sprite.alpha = 0
    transition.to(sprite, { alpha = 1.0 } )
    sceneGroup:insert(sprite)

end

local function requestDesc(e)
    if e.isError then
        print("Error in request: "..e.response)
    else
        local response = e.response
        local data = json.decode(response)
        local des_list = data.flavor_text_entries
        for i =1, #des_list do
            if (des_list[i].language.name == "en") and (des_list[i].version.name=="black") then
                --Show this one 
                print("Matched: "..string.upper(des_list[i].flavor_text))
                desc_txt.text = string.upper(des_list[i].flavor_text)
                desc_txt.anchorX, desc_txt.anchorY = 0, 0
                scrollView:insert(desc_txt)
                desc_txt.alpha = 0
		        transition.to(desc_txt, { alpha = 1.0 } )
                break
            end
        end
    end
end

local function requestData(e)
    if e.isError then
        print("Error in request: "..e.response)
    else
        local response = e.response
        local data = json.decode(response)
        id_txt.text = current_pkmn
        id_txt.alpha = 0
		transition.to(id_txt, { alpha = 1.0 } )
        name_txt.text = string.upper(data.name)
        name_txt.alpha = 0
		transition.to(name_txt, { alpha = 1.0 } )
        height_txt.text = "HT           "..string.upper(data.height)
        height_txt.alpha = 0
		transition.to(height_txt, { alpha = 1.0 } )
        weight_txt.text = "WT           "..string.upper(data.weight)
        weight_txt.alpha = 0
		transition.to(weight_txt, { alpha = 1.0 } )
        sprite_url = data.sprites.versions["generation-v"]["black-white"].front_default
        --sprite_url = data.sprites.versions["generation-v"]
        --for i, val in pairs(sprite_url) do
        --    print("In for")
        --    print(i,val)
        --end
        print(sprite_url)
        print("Height: "..data.height..", Weight: "..data.weight)
    end
    if e.phase == "ended" then
        network.download(sprite_url, "GET", requestSprite,(current_pkmn..".png"),system.TemporaryDirectory )
    end
end

local function next_btn_touch(e)
    print("Next Btn Pressed")
    if current_pkmn < max_pkmn then
        current_pkmn = current_pkmn+1
        --retrieve data
        network.request(poke_api..current_pkmn, "GET", requestData)
        network.request(poke_api_2..current_pkmn, "GET", requestDesc)
    else
        --error message  
    end
    return true
end

local function prev_btn_touch(e)
    print("Prev Btn Pressed")
    if (current_pkmn-1) == 493 then
        --Show error message
    else
        current_pkmn = current_pkmn-1
        network.request(poke_api..current_pkmn, "GET", requestData)
        network.request(poke_api_2..current_pkmn, "GET", requestDesc)
    end
    return true
end

local function textInputListener(event)
    if event.phase == "began" then
        print("Campo de texto seleccionado")
    elseif event.phase == "ended" then
        --Perdio foco
        print("Campo de texto perdió el foco")
        native.setKeyboardFocus(nil) -- Oculta el teclado
    elseif event.phase == "submitted" then
        --Se ha pulsado la tecla "Enter"
        print("Campo de texto submitted")
        print(textField.text)
        native.setKeyboardFocus(nil) -- Oculta el teclado
        if (tonumber(textField.text) >= 494) and tonumber(textField.text) <= 649 then
            --Is a valid pkmn id
            current_pkmn = tonumber(textField.text)
            network.request(poke_api..current_pkmn, "GET", requestData)
            network.request(poke_api_2..current_pkmn, "GET", requestDesc)
        else
            --Not a valid ID
        end
        textField.text = ""
    elseif event.phase == "editing" then
        -- Se está editando el campo de texto
    end
end

function scene:create( event )
    sceneGroup = self.view
    fondo = display.newImageRect(sceneGroup, assetsPath.."Unova/unova_Bg.jpg",CW, CH)
    fondo.x, fondo.y = 0, 0
    fondo.anchorX, fondo.anchorY = 0 , 0

    textField = native.newTextField((CW/2.5),(CH/1.06),200,35)
    textField.inputType = "number"
    textField.font = native.newFont(font,35)
    textField.align = "right"
    textField:setTextColor( 0, 0, 0)
    sceneGroup:insert(textField)

    scrollView = widget.newScrollView({
        top = display.contentHeight/1.6,
        left = (CW/20),
        width = display.contentWidth-(CW/10),
        height = display.contentWidth/6.5, 
        scrollWidth = display.contentWidth,
        scrollHeight = 0,
        hideBackground = true,
        horizontalScrollDisabled = true,
        isBounceEnabled = true
    })

    desc_txt = display.newText({
        text = "",
        width = display.contentWidth-(0+CW/18), --was CH
        height = 0,
        font = font,
        fontSize = 60,
        align = "left",
    })
    desc_txt:setFillColor(1,1,1)
    sceneGroup:insert(desc_txt)
    scrollView:insert(desc_txt)

    next_btn = widget.newButton({
        x = CW/1.1,
        y = CH/1.06,
        width = 150,
        height = 70,
        defaultFile = assetsPath.."Unova/unova_Btn.png",
        label = "NEXT",
        labelColor = { default = { 1, 1, 1}},
        font = font,
        fontSize = 60,
        anchorX=0,
        anchorY=0
    })
    sceneGroup:insert(next_btn)

    prev_btn = widget.newButton({
        x = CW/1.4,
        y = CH/1.06,
        width = 150,
        height = 70,
        defaultFile = assetsPath.."Unova/unova_Btn.png",
        label = "PREV",
        labelColor = { default = { 1, 1, 1}},
        font = font,
        fontSize = 60,
        anchorX=0,
        anchorY=0
    })
    sceneGroup:insert(prev_btn)

    back_btn = widget.newButton({
        x = CW/10,
        y = CH/1.06,
        width = 150,
        height = 70,
        defaultFile = assetsPath.."Unova/unova_Btn.png",
        label = "BACK",
        labelColor = { default = { 1, 1, 1}},
        font = font,
        fontSize = 60,
        anchorX=0,
        anchorY=0
    })
    sceneGroup:insert(back_btn)

    name_txt = display.newText({
        text = "",
        x = CW/1.20,
        y = CH/10,
        width = 400,
        height = 65,
        font = font,
        fontSize = 75,
        align = "left",
        anchorX=0,
        anchorY=0
    })
    name_txt:setFillColor(0,0,0)

    height_txt = display.newText({
        text = "",
        x = CW/1.4,
        y = CH/2.3,
        width = 300,
        height = 70,
        font = font,
        fontSize = 75,
        align = "left",
        anchorX=0,
        anchorY=0
    })
    height_txt:setFillColor(0,0,0)

    weight_txt = display.newText({
        text = "",
        x = CW/1.4,
        y = CH/1.9,
        width = 300,
        height = 70,
        font = font,
        fontSize = 75,
        align = "left",
        anchorX=0,
        anchorY=0
    })
    weight_txt:setFillColor(0,0,0)

    id_txt = display.newText({
        text = "",
        x = CW/1.45,
        y = CH/9,
        width = 300,
        height = 70,
        font = font,
        fontSize = 70,
        align = "left",
        anchorX=0,
        anchorY=0
    })
    id_txt:setFillColor(0,0,0)

    sceneGroup:insert(name_txt)
    sceneGroup:insert(height_txt)
    sceneGroup:insert(weight_txt)
    sceneGroup:insert(id_txt)
    sceneGroup:insert(scrollView)
end

function scene:show( event )

    sceneGroup = self.view
    local phase = event.phase
    print("Ejecucion del show")
    if ( phase == "will" ) then
        print("Dentro del will de la funcion show")
        network.request(poke_api..current_pkmn, "GET", requestData)
        network.request(poke_api_2..current_pkmn, "GET", requestDesc)
    elseif ( phase == "did" ) then
        print("Dentro del did de la funcion show")
        back_btn:addEventListener("tap",back_btn_touch)
        next_btn:addEventListener("tap",next_btn_touch)
        prev_btn:addEventListener("tap",prev_btn_touch)
        textField:addEventListener("userInput", textInputListener)
    end
end

function scene:hide( event )
    sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        composer.removeScene("menu")
    elseif ( phase == "did" ) then
        current_pkmn = 494
        back_btn:removeEventListener("tap",back_btn_touch)
        next_btn:removeEventListener("tap",next_btn_touch)
        prev_btn:removeEventListener("tap",prev_btn_touch)
        textField:removeEventListener("userInput", textInputListener)
        composer.removeScene("unovaDex")
    end
end

function scene:destroy( event )
    --sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene