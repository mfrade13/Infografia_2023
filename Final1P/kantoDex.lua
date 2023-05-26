local composer = require "composer"
local scene = composer.newScene()
local json = require "json"
local network = require "network"
local widget = require("widget")

local current_pkmn = 1
local max_pkmn = 151

local fondo
local sprite
local back_btn
local next_btn
local prev_btn
local sceneGroup

local name_txt
local weight_txt
local height_txt
local desc_txt
local sprite_url

local scrollView
local textField

local function requestSprite(e)
    if e.isError then
        print("Error Downloading Sprite: "..e.response)
    elseif e.phase == "began" then
        print("Began")
    elseif e.phase == "ended" then
        local response = e.response
        print("Filename: "..response.filename)
        print("BaseDirectory: "..tostring(response.baseDirectory))

        display.remove(sprite)
        sprite = nil
        sprite = display.newImageRect(e.response.filename, e.response.baseDirectory, 256, 256)
        sprite.x, sprite.y = (CW-CW/2.85), (CH/6)
        sprite.anchorX, sprite.anchorY = 0 , 0
		sprite.alpha = 0
		transition.to(sprite, { alpha = 1.0 } )
        sceneGroup:insert(sprite)
    end
end

local function requestData(e)
    if e.isError then
        print("Error in request: "..e.response)
    else
        local response = e.response
        local data = json.decode(response)
        name_txt.text = current_pkmn.."   "..string.upper(data.name)
        name_txt.alpha = 0
		transition.to(name_txt, { alpha = 1.0 } )
        height_txt.text = string.upper(data.height)
        height_txt.alpha = 0
		transition.to(height_txt, { alpha = 1.0 } )
        weight_txt.text = string.upper(data.weight)
        weight_txt.alpha = 0
		transition.to(weight_txt, { alpha = 1.0 } )
        sprite_url = data.sprites.versions["generation-i"].yellow.front_default
        print("Height: "..data.height..", Weight: "..data.weight)
        print("Sprite URL: : "..sprite_url)
    end
    if e.phase == "ended" then
        network.download(sprite_url, "GET", requestSprite,(current_pkmn..".png"),system.TemporaryDirectory )
    end
end

local function requestDesc(e)
    if e.isError then
        print("Error in request: "..e.response)
    else
        local response = e.response
        local data = json.decode(response)
        local des_list = data.flavor_text_entries
        for i =1, #des_list do
            if (des_list[i].language.name == "en") and (des_list[i].version.name=="firered") then
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


local function back_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        print("Back Btn Pressed")
        transition.scaleTo(back_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(back_btn, { xScale = 1, yScale = 1, time = 0 })
        composer.gotoScene("menu", "fade", 100)
    end
    return true
end

local function next_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        print("Next Btn Pressed")
        transition.scaleTo(next_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(next_btn, { xScale = 1, yScale = 1, time = 0 })
        if current_pkmn < max_pkmn then
            current_pkmn = current_pkmn+1
            --retrieve data
            network.request(poke_api..current_pkmn, "GET", requestData)
            network.request(poke_api_2..current_pkmn, "GET", requestDesc)
        else
            --error message  
        end
    end
    return true
end


local function prev_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        print("Prev Btn Pressed")
        transition.scaleTo(prev_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(prev_btn, { xScale = 1, yScale = 1, time = 0 })
        if (current_pkmn-1) == 0 then
            --Show error message
        else
            current_pkmn = current_pkmn-1
            network.request(poke_api..current_pkmn, "GET", requestData)
            network.request(poke_api_2..current_pkmn, "GET", requestDesc)
        end
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
        if (tonumber(textField.text) >= 1) and tonumber(textField.text) <= 151 then
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
        --local text = event.text
        -- Elimina cualquier carácter que no sea un número
        --text = text:gsub("[^%d]", "")
        --textField.text = text -- Actualiza el contenido del campo de texto
    end
end

function scene:create( event )
    sceneGroup = self.view
    scrollView = widget.newScrollView({
        top = display.contentHeight/1.7,
        left = (0+CW/25),
        width = display.contentWidth-(CW/15),
        height = display.contentWidth/5, 
        scrollWidth = display.contentWidth,
        scrollHeight = 0,
        hideBackground = true,
        horizontalScrollDisabled = true,
        isBounceEnabled = true
    }
    )
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newImageRect(sceneGroup, assetsPath.."Kanto/kanto_Bg2.jpg",CW, CH)
    fondo.x, fondo.y = 0, 0
    fondo.anchorX, fondo.anchorY = 0 , 0

    textField = native.newTextField((CW/2.2),(CH/17.5),200,40)
    textField.inputType = "number"
    textField.font = native.newFont(font,38)
    textField.align = "right"
    textField:setTextColor( 0, 0, 0)--Letras(negras)
    --textField.hasBackground = true
    --textField.backgroundColor = { 0, 0, 0 }  -- Blanco

    sceneGroup:insert(textField)

    back_btn = display.newImageRect(sceneGroup, assetsPath.."Kanto/back_Btn.png", 150, 75)
    back_btn.x, back_btn.y = 30, (CH-75)
    back_btn.anchorX, back_btn.anchorY = 0, 0

    next_btn = display.newImageRect(sceneGroup, assetsPath.."Kanto/next_Btn.png", 150, 75)
    next_btn.x, next_btn.y = (CW-150), (CH-75)
    next_btn.anchorX, next_btn.anchorY = 0, 0

    prev_btn = display.newImageRect(sceneGroup, assetsPath.."Kanto/prev_Btn.png", 150, 75)
    prev_btn.x, prev_btn.y = (CW-325), (CH-75)
    prev_btn.anchorX, prev_btn.anchorY = 0, 0

    name_txt = display.newText({
        text = "",
        x = CW/3.77,
        y = CH/4.39,
        width = 300,
        height = 50,
        font = font,
        fontSize = 65,
        align = "left",
        anchorX=0,
        anchorY=0
    })
    name_txt:setFillColor(0,0,0)

    height_txt = display.newText({
        text = "",
        x = CW/3.75,
        y = CH/2.47,
        width = 300,
        height = 50,
        font = font,
        fontSize = 60,
        align = "left",
        anchorX=0,
        anchorY=0
    })
    height_txt:setFillColor(0,0,0)

    weight_txt = display.newText({
        text = "",
        x = CW/3.75,
        y = CH/2.08,
        width = 300,
        height = 50,
        font = font,
        fontSize = 60,
        align = "left",
        anchorX=0,
        anchorY=0
    })
    weight_txt:setFillColor(0,0,0)

    desc_txt = display.newText({
        text = "",
        --x = (0+CW/35),
        --y = (CH-CH/2.5),
        width = display.contentWidth-(0+CW/18), --was CH
        height = 0,
        font = font,
        fontSize = 60,
        align = "left",
    })
    desc_txt:setFillColor(0,0,0)
    sceneGroup:insert(desc_txt)
    scrollView:insert(desc_txt)
    
    sceneGroup:insert(name_txt)
    sceneGroup:insert(height_txt)
    sceneGroup:insert(weight_txt)
    sceneGroup:insert(scrollView)
end

function scene:show( event )
 
    sceneGroup = self.view
    local phase = event.phase
    print("Ejecucion del show")
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        print("Dentro del will de la funcion show")
        network.request(poke_api..current_pkmn, "GET", requestData)
        network.request(poke_api_2..current_pkmn, "GET", requestDesc)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("Dentro del did de la funcion show")
        back_btn:addEventListener("touch",back_btn_touch)
        next_btn:addEventListener("touch",next_btn_touch)
        prev_btn:addEventListener("touch",prev_btn_touch)
        textField:addEventListener("userInput", textInputListener)
    end
end

function scene:hide( event )
    sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --fondo:removeEventListener("touch", fondo)
        composer.removeScene("menu")
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        current_pkmn = 1
        back_btn:removeEventListener("touch",back_btn_touch)
        next_btn:removeEventListener("touch",next_btn_touch)
        prev_btn:removeEventListener("touch",prev_btn_touch)
        textField:removeEventListener("userInput", textInputListener)
        composer.removeScene("kantoDex")
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