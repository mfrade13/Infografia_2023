local composer = require( "composer" )
 
local scene = composer.newScene()

math.randomseed(os.time())

local score = 0
local fondo
local playarea
local mira
local brazo
local enemigo1
local enemigo2
local enemigo3
local scoreText
local readyText
local areayini = CH/2 - (6*CH/15)
local areayfin = CH/2 + (6*CH/15)
local transIds = {}

local shotSound
local enemyDieSound
local bgm
local shotOpt
local dieOpt
local bgmOpt

local bgGroup
local uiGroup
local areaGroup
local enemyGroup
local playerGroup

function destroyReady()
    readyText:removeSelf()
end

function blinkReady()
    readyText.isVisible = not readyText.isVisible
end

function resetEnemy(enemy)
    local side = math.random(1,2)
    local xside
    local yside = math.random(areayini,areayfin)
    if (side == 1) then
        xside = 0
    else
        xside = CW
    end
    transition.cancel(transIds[enemy.name])
    enemy.isVisible = false
    transition.to(enemy,{time=2000, x=xside, y=yside, onComplete=moveEnemy})
    return true
end

function moveEnemy(enemy)
    local endx
    if (enemy.x > CW/2) then
        endx = 0
    else
        endx = CW
    end
    enemy.isVisible = true
    transIds[enemy.name] = transition.to(enemy,{ time=3000, x=endx, y=enemy.y, onComplete=resetEnemy})
    return true
end

function moverMira(x,y)
    mira.x = x
    mira.y = y
end

function startGame()
    readyText.isVisible = false
    audio.play(bgm, bgmOpt)
    moveEnemy(enemigo1)
    moveEnemy(enemigo2)
    moveEnemy(enemigo3)
end

function areaTouch(event)
    if event.phase == "began" then
        moverMira(event.x, event.y)
        local angle = math.atan2(event.y - brazo.y, event.x - brazo.x) - math.atan2(CH/2 - brazo.y, CW/2 - brazo.x)
        brazo.rotation = math.deg(angle)
        print(math.deg(angle))
        
    end
    return true
end

function enemyTouch(event)
    local target = event.target
    if event.phase == "began" then
        audio.play(shotSound, shotOpt)
        audio.play(enemyDieSound, dieOpt)
        score = score + 10
        scoreText.text = "SCORE: "..tostring(score)
        moverMira(event.x, event.y)
        local angle = math.atan2(event.y - brazo.y, event.x - brazo.x) - math.atan2(CH/2 - brazo.y, CW/2 - brazo.x)
        brazo.rotation = math.deg(angle)
        target.isVisible = false
        resetEnemy(target)
        local explosion = display.newImageRect(enemyGroup,ASSETS.."explosion.png",target.width,target.height)
        explosion.x = target.x; explosion.y = target.y
        timer.performWithDelay(1500, function()
            
            explosion:removeSelf()
        end)
    end
    return true
end

function scene:create( event )
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    bgGroup = display.newGroup()
    areaGroup = display.newGroup()
    enemyGroup = display.newGroup()
    playerGroup = display.newGroup()
    uiGroup = display.newGroup()
    fondo = display.newImageRect(bgGroup, ASSETS.."fondo.png",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
    playarea = display.newRect(areaGroup, CW/2,CH/2,CW, 12*CH/15 )
    playarea:setFillColor(0,0,1); playarea.isVisible = false; playarea.isHitTestable = true
    brazo = display.newImageRect(playerGroup, ASSETS.."armSprite.png",CW/10, CH/5)
    brazo.AnchorY = 0.5; brazo.x = CW/2; brazo.y = CH
    mira = display.newImageRect(playerGroup, ASSETS.."mira.png", CW/15, CH/15)
    mira.x = CW/2; mira.y = CH/2;
    local textopt = {
        parent = uiGroup,
        text = "SCORE: "..tostring(score),
        x = CW/2,
        y = CH/15,
        width = CW/2,
        font = "MegamaxJones-elRm.ttf",
        fontSize = 15
    }
    scoreText = display.newText(textopt)
    playarea:addEventListener("touch", areaTouch)
    readyText = display.newImageRect(uiGroup, ASSETS.."ready.png", CW/5, CH/15)
    readyText.x = CW/2; readyText.y = CH/2
    enemigo1 = display.newImageRect(enemyGroup, ASSETS.."enemy.png", CW/9, CH/10)
    enemigo1.x = 0; enemigo1.y = CH/4; enemigo1.name = "enemigo1"
    enemigo1:addEventListener("touch", enemyTouch)
    enemigo1.isVisible = false
    enemigo2 = display.newImageRect(enemyGroup, ASSETS.."enemy.png", CW/9, CH/10)
    enemigo2.x = CW; enemigo2.y = CH/2; enemigo2.name = "enemigo2"
    enemigo2:addEventListener("touch", enemyTouch)
    enemigo2.isVisible = false
    enemigo3 = display.newImageRect(enemyGroup, ASSETS.."enemy.png", CW/9, CH/10)
    enemigo3.x = 0; enemigo3.y = 3*CH/4; enemigo3.name = "enemigo3"
    enemigo3:addEventListener("touch", enemyTouch)
    enemigo3.isVisible = false
    shotSound = audio.loadSound(ASSETS.."shot.wav");
    shotOpt = {
        loops = 0,
        duration = audio.getDuration(shotSound);
    }
    enemyDieSound = audio.loadSound(ASSETS.."enemyDie.wav")
    dieOpt = {
        loops = 0,
        duration = audio.getDuration(enemyDieSound)
    }
    bgm = audio.loadSound(ASSETS.."stage.mp3")
    bgmOpt = {
        loops = -1
    }

    sceneGroup:insert(bgGroup)
    sceneGroup:insert(areaGroup)
    sceneGroup:insert(enemyGroup)
    sceneGroup:insert(playerGroup)
    sceneGroup:insert(uiGroup)

    -- local icono = display.newImageRect(sceneGroup, "Icon.png",CW/2, CH/2 )
    -- icono.x = CW/2; icono.y =CH/2
    -- fondo:addEventListener("touch", irMenu)
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        composer.removeScene("menu")
        sceneGroup:insert(bgGroup)
        sceneGroup:insert(areaGroup)
        sceneGroup:insert(enemyGroup)
        sceneGroup:insert(playerGroup)
        sceneGroup:insert(uiGroup)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        local blinkTime = 3000 -- milliseconds
        local blinkTimer

        blinkTimer = timer.performWithDelay(500, blinkReady, blinkTime / 500)
        timer.performWithDelay(blinkTime, function()
            timer.cancel(blinkTimer)
            destroyReady()  -- Destroy the object after 3 seconds
            startGame()
        end)

        
    end
end

function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --fondo:removeEventListener("touch", fondo)
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
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