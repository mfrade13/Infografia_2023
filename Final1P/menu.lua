local composer = require "composer"
local widget = require("widget")

local scene = composer.newScene()
local fondo
local kanto_btn
local nat_btn
local johto_btn
local hoenn_btn
local sinnoh_btn
local unova_btn
local kalos_btn
local alola_btn
local galar_btn
local paldea_btn
local dead

local buttonPadding = 50
local yOffset = buttonPadding


local scrollView = widget.newScrollView({
        top = 87,
        left = 0,
        width = display.contentWidth,
        height = display.contentHeight-80, 
        scrollWidth = display.contentWidth,
        scrollHeight = 0,
        hideBackground = true,
        horizontalScrollDisabled = true,
        isBounceEnabled = true
    }
)

function genericBtn(e, btn)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(btn, { xScale = 1.04, yScale = 1.04, time = 0 })

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(btn, { xScale = 1, yScale = 1, time = 0 })
    end
    return true
end

function kanto_btn_touch(e)
    print("Kanto pressed")
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(kanto_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(kanto_btn, { xScale = 1, yScale = 1, time = 0 })
        composer.gotoScene("kantoDex", "fade", 100)
    end
    return true
end

function nat_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(nat_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
        

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(nat_btn, { xScale = 1, yScale = 1, time = 0 })
    end
    return true
end

function johto_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(johto_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(johto_btn, { xScale = 1, yScale = 1, time = 0 })
        composer.gotoScene("johtoDex", "fade", 100)
    end
    return true
end

function hoenn_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(hoenn_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
        

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(hoenn_btn, { xScale = 1, yScale = 1, time = 0 })
        composer.gotoScene("hoennDex", "fade", 100)
    end
    return true
end

function sinnoh_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(sinnoh_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
        

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(sinnoh_btn, { xScale = 1, yScale = 1, time = 0 })
        composer.gotoScene("sinnohDex", "fade", 100)
    end
    return true
end

function unova_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(unova_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
        

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(unova_btn, { xScale = 1, yScale = 1, time = 0 })
        composer.gotoScene("unovaDex", "fade", 100)
    end
    return true
end

function kalos_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(kalos_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
        

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(kalos_btn, { xScale = 1, yScale = 1, time = 0 })
    end
    return true
end

function alola_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(alola_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
        

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(alola_btn, { xScale = 1, yScale = 1, time = 0 })
    end
    return true
end

function galar_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(galar_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
        

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(galar_btn, { xScale = 1, yScale = 1, time = 0 })
    end
    return true
end

function paldea_btn_touch(e)
    if e.phase == "began" then
        -- Escala la imagen a un tamaño más grande durante un segundo
        transition.scaleTo(paldea_btn, { xScale = 1.04, yScale = 1.04, time = 0 })
        

    elseif e.phase == "ended" or e.phase == "cancelled" then
        -- Vuelve a escalar la imagen a su tamaño original durante un segundo
        transition.scaleTo(paldea_btn, { xScale = 1, yScale = 1, time = 0 })
    end
    return true
end

function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    fondo = display.newImageRect(sceneGroup, assetsPath.."BackgroundImgs/menuBg.jpg",CW, CH )
    fondo.x, fondo.y = 0, 0
    fondo.anchorX, fondo.anchorY = 0 , 0

    kanto_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Kanto_Btn.jpg", CW, 80)
    kanto_btn.x, kanto_btn.y = 0, (50+(0*130))
    kanto_btn.anchorX, kanto_btn.anchorY = 0, 0
    scrollView:insert(kanto_btn)
    yOffset = yOffset + kanto_btn.height + buttonPadding

    nat_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Nat_Btn.jpg", CW, 80)
    nat_btn.x, nat_btn.y = 0,(50+(5*130))
    nat_btn.anchorX, nat_btn.anchorY = 0, 0
    scrollView:insert(nat_btn)
    yOffset = yOffset + nat_btn.height + buttonPadding

    johto_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Johto_Btn.jpg", CW, 80)
    johto_btn.x, johto_btn.y = 0,(50+(1*130))
    johto_btn.anchorX, johto_btn.anchorY = 0, 0
    scrollView:insert(johto_btn)
    yOffset = yOffset + johto_btn.height + buttonPadding

    hoenn_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Hoenn_Btn.jpg", CW, 80)
    hoenn_btn.x, hoenn_btn.y = 0,(50+(2*130))
    hoenn_btn.anchorX, hoenn_btn.anchorY = 0, 0
    scrollView:insert(hoenn_btn)
    yOffset = yOffset + hoenn_btn.height + buttonPadding

    sinnoh_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Sinnoh_Btn.jpg", CW, 80)
    sinnoh_btn.x, sinnoh_btn.y = 0,(50+(3*130))
    sinnoh_btn.anchorX, sinnoh_btn.anchorY = 0, 0
    scrollView:insert(sinnoh_btn)
    yOffset = yOffset + sinnoh_btn.height + buttonPadding

    unova_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Unova_Btn.jpg", CW, 80)
    unova_btn.x, unova_btn.y = 0,(50+(4*130))
    unova_btn.anchorX, unova_btn.anchorY = 0, 0
    scrollView:insert(unova_btn)
    yOffset = yOffset + unova_btn.height + buttonPadding

    kalos_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Kalos_Btn.jpg", CW, 80)
    kalos_btn.x, kalos_btn.y = 0,(50+(6*130))
    kalos_btn.anchorX, kalos_btn.anchorY = 0, 0
    scrollView:insert(kalos_btn)
    yOffset = yOffset + kalos_btn.height + buttonPadding

    alola_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Alola_Btn.jpg", CW, 80)
    alola_btn.x, alola_btn.y = 0,(50+(7*130))
    alola_btn.anchorX, alola_btn.anchorY = 0, 0
    scrollView:insert(alola_btn)
    yOffset = yOffset + alola_btn.height + buttonPadding

    galar_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Galar_Btn.jpg", CW, 80)
    galar_btn.x, galar_btn.y = 0,(50+(8*130))
    galar_btn.anchorX, galar_btn.anchorY = 0, 0
    scrollView:insert(galar_btn)
    yOffset = yOffset + galar_btn.height + buttonPadding

    paldea_btn = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Paldea_Btn.jpg", CW, 80)
    paldea_btn.x, paldea_btn.y = 0,(50+(9*130))
    paldea_btn.anchorX, paldea_btn.anchorY = 0, 0
    scrollView:insert(paldea_btn)
    yOffset = yOffset + paldea_btn.height + buttonPadding
    --local currentScrollHeight = scrollView.scrollHeight
    --scrollView.scrollHeight = currentScrollHeight + 100

    dead = display.newImageRect(sceneGroup, assetsPath.."Buttons/pkdex_Kalos_Btn.jpg", CW, 50)
    dead.x, dead.y = 0,(50+(10*130))
    dead.anchorX, dead.anchorY = 0, 0
    scrollView:insert(dead)
    yOffset = yOffset + dead.height + buttonPadding
    dead.isVisible = false
    
    sceneGroup:insert(scrollView)
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    print("Ejecucion del show de MENU")
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        print("Dentro del will de la funcion show")

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("Dentro del did de la funcion show")
        kanto_btn:addEventListener("touch",kanto_btn_touch)
        nat_btn:addEventListener("touch",nat_btn_touch)
        johto_btn:addEventListener("touch",johto_btn_touch)
        hoenn_btn:addEventListener("touch",hoenn_btn_touch)
        sinnoh_btn:addEventListener("touch",sinnoh_btn_touch)
        unova_btn:addEventListener("touch",unova_btn_touch)
        kalos_btn:addEventListener("touch",kalos_btn_touch)
        alola_btn:addEventListener("touch",alola_btn_touch)
        galar_btn:addEventListener("touch",galar_btn_touch)
        paldea_btn:addEventListener("touch",paldea_btn_touch)
        --fondo:addEventListener("touch", irJuego)
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --fondo:removeEventListener("touch", fondo)
        composer.removeScene("kantoDex")
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        kanto_btn:removeEventListener("touch",kanto_btn_touch)
        nat_btn:removeEventListener("touch",nat_btn_touch)
        johto_btn:removeEventListener("touch",johto_btn_touch)
        hoenn_btn:removeEventListener("touch",hoenn_btn_touch)
        sinnoh_btn:removeEventListener("touch",sinnoh_btn_touch)
        unova_btn:removeEventListener("touch",unova_btn_touch)
        kalos_btn:removeEventListener("touch",kalos_btn_touch)
        alola_btn:removeEventListener("touch",alola_btn_touch)
        galar_btn:removeEventListener("touch",galar_btn_touch)
        paldea_btn:removeEventListener("touch",paldea_btn_touch)
        composer.removeScene("menu")
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -----------------------------------------------------------------------------------
return scene