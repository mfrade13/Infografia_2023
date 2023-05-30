
-- Librerias
local composer = require( "composer" )
local widget = require( "widget" )

--Grupo Principal
local worldGroup = display.newGroup()
local scene = composer.newScene()
-- Timer
local tPrevious = system.getTimer()

-- Variables Locales
local altura = CH/4
local ancho = CW/12

local fondo
local grupoCircular
local grupoGrillas
local grupoEstatico
local sceneGroup

local sol
local mercurio
local venus
local tierra
local marte
local jupiter
local saturno
local urano
local neptuno
local luna_tierra
local luna_fobos
local luna_deimos

local radio_S2Mercurio
local radio_S2venus
local radio_S2tierra
local radio_S2marte
local radio_S2jupiter
local radio_S2saturno
local radio_S2urano
local radio_S2neptuno
local radio_T2luna
local radio_T2fobos
local radio_T2deimos

local periodo_mercurio
local periodo_venus
local periodo_tierra
local periodo_marte
local periodo_jupiter
local periodo_saturno
local periodo_urano
local periodo_neptuno
local periodo_lunaT
local periodo_fobos
local periodo_deimos

local orbita_merurio
local orbita_venus
local orbita_tierra
local orbita_marte
local orbita_jupiter
local orbita_saturno
local orbita_urano
local orbita_neptuno
local orbita_fobos
local orbita_deimos
local orbita_lunaT

local onOffSwitch_Stop
local pausarGrupoCirclar
local checkButton_mercurio

-- Grupo Circular
grupoCircular = display.newGroup(worldGroup, 1024, 768)
grupoCircular.x, grupoCircular.y = 0,0
grupoCircular.anchorX = 0;grupoCircular.anchorY = 0

-- Grupo Estatico
grupoEstatico = display.newGroup(worldGroup, 1024, 768)
grupoEstatico.x, grupoEstatico.y = 0,0
grupoEstatico.anchorX = 0;grupoEstatico.anchorY = 0


function actualizar_estado_mercurio(event)
    if tostring(event.target.isOn) == "false" then
        mercurio.alpha = 0
    elseif tostring(event.target.isOn) == "true" then
        mercurio.alpha = 1
    end
    return true
end
function actualizar_estado_venus(event)
    if tostring( event.target.isOn) == "false" then
        venus.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        venus.alpha = 1
    end
    return true
end
function actualizar_estado_tierra(event)
    if tostring( event.target.isOn) == "false" then
        tierra.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        tierra.alpha = 1
    end
    return true
end
function actualizar_estado_jupiter(event)
    if tostring( event.target.isOn) == "false" then
        jupiter.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        jupiter.alpha = 1
    end
    return true
end
function actualizar_estado_marte(event)
    if tostring( event.target.isOn) == "false" then
        marte.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        marte.alpha = 1
    end
    return true
end
function actualizar_estado_saturno(event)
    if tostring( event.target.isOn) == "false" then
        saturno.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        saturno.alpha = 1
    end
    return true
end
function actualizar_estado_urano(event)
    if tostring( event.target.isOn) == "false" then
        urano.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        urano.alpha = 1
    end
    return true
end
function actualizar_estado_neptuno(event)
    if tostring( event.target.isOn) == "false" then
        neptuno.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        neptuno.alpha = 1
    end
    return true
end
-- == Lunas ==== ---
function actualizar_estado_lunaT(event)
    if tostring( event.target.isOn) == "false" then
        luna_tierra.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        luna_tierra.alpha = 1
    end
    return true
end
function actualizar_estado_fobos(event)
    if tostring( event.target.isOn) == "false" then
        luna_fobos.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        luna_fobos.alpha = 1
    end
    return true
end
function actualizar_estado_deimos(event)
    if tostring( event.target.isOn) == "false" then
        luna_deimos.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        luna_deimos.alpha = 1
    end
    return true
end
function actualizar_velocidad(event)
    periodo_mercurio = event.value * 100
end

--  Stop Escenario Sistema
function onOffSwitchListener_Stop(event)
    if tostring( event.target.isOn) == "true" then
        grupoCircular.isVisible = false
        grupoEstatico.alpha = 0
        grupoGrillas.alpha = 0
    elseif tostring( event.target.isOn) == "false" then
        grupoCircular.isVisible = true
        grupoEstatico.alpha = 1
        grupoGrillas.alpha = 1
    end
    return true
end

--  Ocultar Orbitas
function onOffSwitchListener_Orbitas(event)
    if tostring( event.target.isOn) == "false" then
        grupoEstatico.alpha = 0
    elseif tostring( event.target.isOn) == "true" then
        grupoEstatico.alpha = 1
    end
    return true
end

--  Efecto Back Hole
function onOffSwitchListener_BlackHoles(event)
    if tostring( event.target.isOn) == "true" then
        composer.gotoScene( "splashScreen", "Fade" )
    elseif tostring( event.target.isOn) == "false" then
        grupoEstatico.alpha = 1
    end
    return true
end

-- ====== CREATE =======
function scene:create( event )
    local fondo_sistema = {
        type = "image",
        filename = "Assets/space1.jpg"
    }
    sceneGroup = self.view
    grupoGrillas = display.newGroup()

    fondo = display.newRect( sceneGroup, 0, 0, CW, CH)
    fondo.x, fondo.y = 0,0
    fondo.anchorX = 0; fondo.anchorY = 0        
    fondo.fill = fondo_sistema

    for i=1,4 do
        local line = display.newLine(grupoGrillas, 0, altura*i, CW, altura*i)
        line.strokeWidth = 2
        line:setStrokeColor(1,1,1,0.2)
    end

    for i=1,12 do
        local line = display.newLine(grupoGrillas, ancho*i, 0, ancho*i, CH)
        line.strokeWidth = 2
        line:setStrokeColor(1,1,1,0.2)
    end

    sol = display.newImageRect(grupoCircular, "Assets/sol.png",426/3,405/3)
    sol.x = 2*ancho; sol.y = 2*altura

    mercurio = display.newImageRect(grupoCircular, "Assets/mercurio.png",426/8,405/8)
    mercurio.x = 3*ancho; mercurio.y = 2*altura
    --mercurio.isVisible = false

    venus = display.newImageRect(grupoCircular, "Assets/venus.png",426/7.5,405/7.5)
    venus.x = 4*ancho; venus.y = 2*altura

    tierra = display.newImageRect(grupoCircular, "Assets/tierra.png",426/7.5,405/7.5)
    tierra.x = 5*ancho; tierra.y = 2*altura

    marte = display.newImageRect(grupoCircular, "Assets/marte.png",426/8,405/8)
    marte.x = 6*ancho; marte.y = 2*altura

    jupiter = display.newImageRect(grupoCircular, "Assets/jupiter.png",426/3.5,405/3.5)
    jupiter.x = 7*ancho; jupiter.y = 2*altura

    saturno = display.newImageRect(grupoCircular, "Assets/saturno.png",426/4,405/4)
    saturno.x = 8*ancho; saturno.y = 2*altura

    urano = display.newImageRect(grupoCircular, "Assets/urano.png",426/5,405/5)
    urano.x = 9*ancho; urano.y = 2*altura

    neptuno = display.newImageRect(grupoCircular, "Assets/neptuno.png",426/5,405/5)
    neptuno.x = 10*ancho; neptuno.y = 2*altura

    luna_tierra = display.newImageRect(grupoCircular, "Assets/luna_tierra.png",612/21,408/21)
    luna_tierra.x = 5*ancho; luna_tierra.y = 2.2*altura

    luna_fobos = display.newImageRect(grupoCircular, "Assets/luna1_marte.png",612/24,408/24)
    luna_fobos.x = 6*ancho; luna_fobos.y = 1.8*altura

    luna_deimos = display.newImageRect(grupoCircular, "Assets/luna2_marte.png",612/24,408/24)
    luna_deimos.x = 6*ancho; luna_deimos.y = 2.2*altura

    mostrar_panelControl()
    
end
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
        dibujar_orbitas()
    end
end

-- ====== HIDE =======
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
        local optionsDespedida =
        {
            text = "Black Hole",
            font = "SpaceGrotesk-Bold",
            fontSize = 25,
            align = "center",
            x = 3*ancho,
            y = 1.5*altura
        }
        local text_despedida = display.newText(optionsDespedida)
 
    end
end

-- ====== DESTROY =======
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end

function mostrar_panelControl()
    local panel_control = display.newRect(grupoEstatico,10.5*ancho,0,1.5*ancho,CH)
    panel_control.anchorX = 0;panel_control.anchorY = 0
    panel_control.alpha = 0.25
    
    -- On/off switch
    onOffSwitch_Stop = widget.newSwitch {
        style = "onOff",
		initialSwitchState = false,
        onRelease = onOffSwitchListener_Stop,
	}
	onOffSwitch_Stop.y = 0.26*altura; onOffSwitch_Stop.x = 11.3*ancho 
	sceneGroup:insert( onOffSwitch_Stop )
    pausarGrupoCirclar = false

    -- Checkbox set

	checkButton_mercurio = widget.newSwitch {
		style = "checkbox",
		initialSwitchState = true,
        isOn = true,
        onPress = actualizar_estado_mercurio
	}
	checkButton_mercurio.y = altura*0.65; checkButton_mercurio.x = ancho*11
    sceneGroup:insert( checkButton_mercurio )
    
	local checkButton_venus = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_venus,
	}
	checkButton_venus.x = ancho*11.5
	checkButton_venus.y = altura*0.65
    sceneGroup:insert( checkButton_venus )

    local checkButton_tierra = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_tierra,
	}
	checkButton_tierra.x = ancho*11
	checkButton_tierra.y = altura
    sceneGroup:insert( checkButton_tierra )

    local checkButton_marte = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_marte,
	}
	checkButton_marte.x = ancho*11.5
	checkButton_marte.y = altura
    sceneGroup:insert( checkButton_marte )

    local checkButton_jupiter = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_jupiter,
	}
    checkButton_jupiter.x = ancho*11
	checkButton_jupiter.y = altura*1.35
    sceneGroup:insert( checkButton_jupiter )

	local checkButton_saturno = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_saturno,
	}
	checkButton_saturno.x = ancho*11.5
	checkButton_saturno.y = altura*1.35
    sceneGroup:insert( checkButton_saturno )

    local checkButton_urano = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_urano,
	}
	checkButton_urano.x = ancho*11
	checkButton_urano.y = altura*1.7
    sceneGroup:insert( checkButton_urano )

    local checkButton_neptuno = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_neptuno,
	}
	checkButton_neptuno.x = ancho*11.5
	checkButton_neptuno.y = altura*1.7
    sceneGroup:insert( checkButton_neptuno )

    -- On/off switch
	local onOffSwitch_orbitas = widget.newSwitch {
		style = "onOff",
		initialSwitchState = true,
        onRelease = onOffSwitchListener_Orbitas,
	}
	onOffSwitch_orbitas.y = 2.05*altura; onOffSwitch_orbitas.x = 11.3*ancho 
	sceneGroup:insert( onOffSwitch_orbitas )

    -- Checkbox Lunas
    local checkButton_lunaT = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_lunaT,
	}
	checkButton_lunaT.x = ancho*11.25
	checkButton_lunaT.y = altura*2.37
    sceneGroup:insert( checkButton_lunaT )

    local checkButton_fobos = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_fobos,
	}
	checkButton_fobos.x = ancho*11
	checkButton_fobos.y = altura*2.75
    sceneGroup:insert( checkButton_fobos )

    local checkButton_deimos = widget.newSwitch {
		style = "checkbox",
        initialSwitchState = true,
        onPress = actualizar_estado_deimos,
	}
	checkButton_deimos.x = ancho*11.5
	checkButton_deimos.y = altura*2.75
    sceneGroup:insert( checkButton_deimos )

	-- ==== Create a horizontal slider ====
    local themeID = composer.getVariable( "themeID" )
    
    local labelColor = { 0 }
    if ( themeID == "widget_theme_android_holo_dark" ) then
        labelColor = { 1 }
    end

	local horizontalSlider = widget.newSlider {
		left = ancho*10.7,
		top = altura*3,
		width = 100,
		id = "Horizontal Slider",
		listener = actualizar_velocidad
	}
	sceneGroup:insert( horizontalSlider )

    -- On/off switch
	local onOffSwitch_balckHole = widget.newSwitch {
		style = "onOff",
		initialSwitchState = false,
        onRelease = onOffSwitchListener_BlackHoles,
	}
	onOffSwitch_balckHole.y = 3.52*altura; onOffSwitch_balckHole.x = 11.3*ancho 
	sceneGroup:insert( onOffSwitch_balckHole )

    -- === TEXTS SECTION ===== --
    local optionsTitle =
    {
        text = "PANEL CONTROL",
        font = "SpaceGrotesk-Bold",
        fontSize = 14,
        align = "center"
    }
    local text_cpTitle = display.newText(optionsTitle)
    text_cpTitle.x = 11.3*ancho; text_cpTitle.y = 0.09*altura
    
    local optionsStop =
    {
        text = "Stop Time",
        font = "SpaceGrotesk-Light",
        fontSize = 14,
        align = "center",
        x = 11.35*ancho,
        y = 0.45*altura
    }
    local text_cpStol = display.newText(optionsStop)

    local optionsStop =
    {
        text = "Stop Time",
        font = "SpaceGrotesk-Light",
        fontSize = 14,
        align = "center",
        x = 11.35*ancho,
        y = 0.45*altura
    }
    local text_cpStol = display.newText(optionsStop)

    local optionsMercurio =
    {
        text = "Mercurio",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11*ancho,
        y = 0.78*altura
    }
    local text_cpMercurio = display.newText(optionsMercurio)

    local optionsVenus =
    {
        text = "Venus",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11.6*ancho,
        y = 0.78*altura
    }
    local text_cpVenus = display.newText(optionsVenus)

    local optionsTierra =
    {
        text = "Tierra",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11*ancho,
        y = 1.15*altura
    }
    local text_cpTierra = display.newText(optionsTierra)

    local optionsMarte =
    {
        text = "Marte",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11.6*ancho,
        y = 1.15*altura
    }
    local text_cpMarte = display.newText(optionsMarte)

    local optionsJupiter =
    {
        text = "Jupiter",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11*ancho,
        y = 1.5*altura
    }
    local text_cpJupiter = display.newText(optionsJupiter)

    local optionsSaturno =
    {
        text = "Saturno",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11.6*ancho,
        y = 1.5*altura
    }
    local text_cpSaturno = display.newText(optionsSaturno)

    local optionsUrano =
    {
        text = "Urano",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11*ancho,
        y = 1.85*altura
    }
    local text_cpUrano = display.newText(optionsUrano)

    local optionsNeptuno =
    {
        text = "Neptuno",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11.6*ancho,
        y = 1.85*altura
    }
    local text_cpNeptuno = display.newText(optionsNeptuno)

    local optionsOrbitasStatus =
    {
        text = "Show Orbitas",
        font = "SpaceGrotesk-Bold",
        fontSize = 12,
        align = "center",
        x = 11.3*ancho,
        y = 2.2*altura
    }
    local text_cpOrbitasStatus = display.newText(optionsOrbitasStatus)

    local optionsLunaT =
    {
        text = "Luna",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11.25*ancho,
        y = 2.55*altura
    }
    local text_cpLunaT = display.newText(optionsLunaT)

    local optionsFobos =
    {
        text = "Fobos",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 10.95*ancho,
        y = 2.88*altura
    }
    local text_cpFobos = display.newText(optionsFobos)

    local optionsDeimos =
    {
        text = "Deimos",
        font = "SpaceGrotesk-Light",
        fontSize = 12,
        align = "center",
        x = 11.55*ancho,
        y = 2.88*altura
    }
    local text_cpDeimos = display.newText(optionsDeimos)

    local optionSpeed =
    {
        text = "Speed Planets",
        font = "SpaceGrotesk-Bold",
        fontSize = 12,
        align = "center",
        x = 11.25*ancho,
        y = 3.3*altura
    }
    local textSpeed = display.newText(optionSpeed)

    local optionsBlackHole =
    {
        text = "BLACK HOLE",
        font = "SpaceGrotesk-Bold",
        fontSize = 12,
        align = "center",
        x = 11.25*ancho,
        y = 3.75*altura
    }
    local textBlackHole = display.newText(optionsBlackHole)


end
function dibujar_orbitas()
    orbita_merurio = display.newCircle(grupoEstatico,sol.x, sol.y, radio_S2Mercurio)
    orbita_merurio:setFillColor(0,0,0,0)
    orbita_merurio:setStrokeColor(255, 0, 128)
    orbita_merurio.strokeWidth = 2
    orbita_merurio.alpha = 0.35

    orbita_venus = display.newCircle(grupoEstatico,sol.x, sol.y, radio_S2venus)
    orbita_venus:setFillColor(0,0,0,0)
    orbita_venus:setStrokeColor(0, 255, 255)
    orbita_venus.strokeWidth = 2
    orbita_venus.alpha = 0.35

    orbita_tierra = display.newCircle(grupoEstatico,sol.x, sol.y, radio_S2tierra)
    orbita_tierra:setFillColor(0,0,0,0)
    orbita_tierra:setStrokeColor(255, 165, 0)
    orbita_tierra.strokeWidth = 2
    orbita_tierra.alpha = 0.35

    orbita_marte = display.newCircle(grupoEstatico,sol.x, sol.y, radio_S2marte)
    orbita_marte:setFillColor(0,0,0,0)
    orbita_marte:setStrokeColor(0, 255, 255)
    orbita_marte.strokeWidth = 2
    orbita_marte.alpha = 0.35

    orbita_jupiter = display.newCircle(grupoEstatico,sol.x, sol.y, radio_S2jupiter)
    orbita_jupiter:setFillColor(0,0,0,0)
    orbita_jupiter:setStrokeColor(0, 255, 0)
    orbita_jupiter.strokeWidth = 2
    orbita_jupiter.alpha = 0.35

    orbita_saturno = display.newCircle(grupoEstatico,sol.x, sol.y, radio_S2saturno)
    orbita_saturno:setFillColor(0,0,0,0)
    orbita_saturno:setStrokeColor(255, 0, 255)
    orbita_saturno.strokeWidth = 2
    orbita_saturno.alpha = 0.35

    orbita_neptuno = display.newCircle(grupoEstatico,sol.x, sol.y, radio_S2neptuno)
    orbita_neptuno:setFillColor(0,0,0,0)
    orbita_neptuno:setStrokeColor(255, 0, 128)
    orbita_neptuno.strokeWidth = 2
    orbita_neptuno.alpha = 0.35

    orbita_urano = display.newCircle(grupoEstatico,sol.x, sol.y, radio_S2urano)
    orbita_urano:setFillColor(0,0,0,0)
    orbita_urano:setStrokeColor(255, 165, 0)
    orbita_urano.strokeWidth = 2
    orbita_urano.alpha = 0.35

end

local function move( event )
    local tDelta = (event.time - tPrevious)
    tPrevious = event.time
    -- ==== MERCURIO ==== 
    periodo_mercurio = 100000                                -- Milisegundos
    radio_S2Mercurio = ancho
    local W_mercurio = radio_S2Mercurio*(math.pi)/periodo_mercurio -- rad/milisegundos
    local angulo_mercurio = W_mercurio * tDelta                          -- alpha = w * t 
    local dif_x_mercurio = mercurio.x - sol.x                      -- (x - xo)
    local dif_y_mercurio = mercurio.y - sol.y                      -- (y - yo)

    local x_prima_mercurio = math.cos(angulo_mercurio)*dif_x_mercurio - math.sin(angulo_mercurio)*dif_y_mercurio
    local y_prima_mercurio = math.sin(angulo_mercurio)*dif_x_mercurio + math.cos(angulo_mercurio)*dif_y_mercurio

    mercurio.x = x_prima_mercurio + sol.x
    mercurio.y = y_prima_mercurio + sol.y

    -- ==== VENUS ==== 
    periodo_venus = 500000                             -- Milisegundos
    radio_S2venus = 2*ancho
    local W_venus = radio_S2venus*(math.pi)/periodo_venus    -- rad/milisegundos
    local angulo_venus = W_venus * tDelta                          -- alpha = w * t 
    local dif_x_venus = venus.x - sol.x                      -- (x - xo)
    local dif_y_venus = venus.y - sol.y                      -- (y - yo)

    local x_prima_venus = math.cos(angulo_venus)*dif_x_venus - math.sin(angulo_venus)*dif_y_venus
    local y_prima_venus = math.sin(angulo_venus)*dif_x_venus + math.cos(angulo_venus)*dif_y_venus

    venus.x = x_prima_venus + sol.x
    venus.y = y_prima_venus + sol.y

    -- ==== TIERRA ==== 
    periodo_tierra = 1000000                             -- Milisegundos
    radio_S2tierra = 3*ancho
    local W_tierra = radio_S2tierra*(math.pi)/periodo_tierra    -- rad/milisegundos
    local angulo_tierra = W_tierra * tDelta                          -- alpha = w * t 
    local dif_x_tierra = tierra.x - sol.x                      -- (x - xo)
    local dif_y_tierra = tierra.y - sol.y                      -- (y - yo)

    local x_prima_tierra = math.cos(angulo_tierra)*dif_x_tierra - math.sin(angulo_tierra)*dif_y_tierra
    local y_prima_tierra = math.sin(angulo_tierra)*dif_x_tierra + math.cos(angulo_tierra)*dif_y_tierra

    tierra.x = x_prima_tierra + sol.x
    tierra.y = y_prima_tierra + sol.y

    -- ==== MARTE ELIPSE ==== 
    -- ======= Movimiento eliptico ======
    -- local periodo_marte = 100000                        -- Milisegundos
    -- local radio_S2marte = 4*ancho
    -- local W_marte = radio_S2marte*(math.pi)/periodo_marte    -- rad/milisegundos
    -- local angulo_marte = W_marte * tDelta                          -- alpha = w * t 
    -- local dif_x_marte = marte.x - sol.x                      -- (x - xo)
    -- local dif_y_marte = marte.y - sol.y
    -- local s_x_marte = 4*ancho                                -- escala a
    -- local s_y_marte = 3*altura                             -- escala b
    
    -- local x_prima_marte = math.cos(angulo_marte)*dif_x_marte - math.sin(angulo_marte)*dif_y_marte
    -- local y_prima_marte = math.sin(angulo_marte)*dif_x_marte + math.cos(angulo_marte)*dif_y_marte

    -- print("Primos",x_prima_marte,y_prima_marte)
    -- local x_final_marte = s_x_marte*x_prima_marte
    -- local y_final_marte = s_y_marte*y_prima_marte

    -- marte.x = x_final_marte + sol.x
    -- marte.y = y_final_marte + sol.y

    periodo_marte = 1000000                             -- Milisegundos
    radio_S2marte = 3*ancho
    local W_marte = radio_S2marte*(math.pi)/periodo_marte    -- rad/milisegundos
    local angulo_marte = W_marte * tDelta                          -- alpha = w * t 
    local dif_x_marte = marte.x - sol.x                      -- (x - xo)
    local dif_y_marte = marte.y - sol.y                      -- (y - yo)

    local x_prima_marte = math.cos(angulo_marte)*dif_x_marte - math.sin(angulo_marte)*dif_y_marte
    local y_prima_marte = math.sin(angulo_marte)*dif_x_marte + math.cos(angulo_marte)*dif_y_marte

    marte.x = x_prima_marte + sol.x
    marte.y = y_prima_marte + sol.y

    -- ==== JUPITER ==== 
    periodo_jupiter = 1000000                              -- Milisegundos
    radio_S2jupiter = 5*ancho
    local W_jupiter = radio_S2jupiter*(math.pi)/periodo_jupiter  -- rad/milisegundos
    local angulo_jupiter = W_jupiter * tDelta                    -- alpha = w * t 
    local dif_x_jupiter = jupiter.x - sol.x                      -- (x - xo)
    local dif_y_jupiter = jupiter.y - sol.y                      -- (y - yo)

    local x_prima_jupiter = math.cos(angulo_jupiter)*dif_x_jupiter - math.sin(angulo_jupiter)*dif_y_jupiter
    local y_prima_jupiter = math.sin(angulo_jupiter)*dif_x_jupiter + math.cos(angulo_jupiter)*dif_y_jupiter

    jupiter.x = x_prima_jupiter + sol.x
    jupiter.y = y_prima_jupiter + sol.y

    -- ==== SATURNO ==== 
    periodo_saturno = 1000000                              -- Milisegundos
    radio_S2saturno = 6*ancho
    local W_saturno = radio_S2saturno*(math.pi)/periodo_saturno  -- rad/milisegundos
    local angulo_saturno = W_saturno * tDelta                    -- alpha = w * t 
    local dif_x_saturno = saturno.x - sol.x                      -- (x - xo)
    local dif_y_saturno = saturno.y - sol.y                      -- (y - yo)

    local x_prima_saturno = math.cos(angulo_saturno)*dif_x_saturno - math.sin(angulo_saturno)*dif_y_saturno
    local y_prima_saturno = math.sin(angulo_saturno)*dif_x_saturno + math.cos(angulo_saturno)*dif_y_saturno

    saturno.x = x_prima_saturno + sol.x
    saturno.y = y_prima_saturno + sol.y

    -- ==== URANO ==== 
    periodo_urano = 1000000                             -- Milisegundos
    radio_S2urano = 7*ancho
    local W_urano = radio_S2urano*(math.pi)/periodo_urano  -- rad/milisegundos
    local angulo_urano = W_urano * tDelta                    -- alpha = w * t 
    local dif_x_urano = urano.x - sol.x                      -- (x - xo)
    local dif_y_urano = urano.y - sol.y                      -- (y - yo)

    local x_prima_urano = math.cos(angulo_urano)*dif_x_urano - math.sin(angulo_urano)*dif_y_urano
    local y_prima_urano = math.sin(angulo_urano)*dif_x_urano + math.cos(angulo_urano)*dif_y_urano

    urano.x = x_prima_urano + sol.x
    urano.y = y_prima_urano + sol.y


    -- ==== NEPTUNO ==== 
    periodo_neptuno = 1000000                               -- Milisegundos
    radio_S2neptuno = 8*ancho
    local W_neptuno = radio_S2neptuno*(math.pi)/periodo_neptuno  -- rad/milisegundos
    local angulo_neptuno = W_neptuno * tDelta                    -- alpha = w * t 
    local dif_x_neptuno = neptuno.x - sol.x                      -- (x - xo)
    local dif_y_neptuno = neptuno.y - sol.y                      -- (y - yo)

    local x_prima_neptuno = math.cos(angulo_neptuno)*dif_x_neptuno - math.sin(angulo_neptuno)*dif_y_neptuno
    local y_prima_neptuno = math.sin(angulo_neptuno)*dif_x_neptuno + math.cos(angulo_neptuno)*dif_y_neptuno

    neptuno.x = x_prima_neptuno + sol.x
    neptuno.y = y_prima_neptuno + sol.y

    -- ==== HERMOSA LUNA TERRESTRE ==== 
    -- 5 ancho , 2.2 altura
    radio_T2luna = ancho/2
    periodo_lunaT = 500000
    local W_lunaT = radio_T2luna*(math.pi)/periodo_lunaT
    local angulo_lunaT = W_lunaT * tDelta
    
    local x_rel_lunaT = radio_T2luna*math.cos(angulo_lunaT)
    local y_rel_lunaT = radio_T2luna*math.sin(angulo_lunaT)

    luna_tierra.x = tierra.x + x_rel_lunaT
    luna_tierra.y = tierra.y + y_rel_lunaT

    -- ==== LUNA FOBOS ====
    radio_T2fobos = ancho/3
    periodo_fobos = 500000
    local W_fobos = radio_T2fobos*(math.pi)/periodo_fobos
    local angulo_fobos = W_fobos * tDelta
    
    local x_rel_fobos = radio_T2fobos*math.cos(angulo_fobos)
    local y_rel_fobos = radio_T2fobos*math.sin(angulo_fobos)

    luna_fobos.x = marte.x + x_rel_fobos
    luna_fobos.y = marte.y + y_rel_fobos

    -- ==== LUNA DEIMOS ====
    radio_T2deimos = ancho/3
    periodo_deimos = 500000
    local W_deimos = radio_T2deimos*(math.pi)/periodo_deimos
    local angulo_deimos = (W_deimos * tDelta) + math.pi
    
    local x_rel_deimos = radio_T2deimos*math.cos(angulo_deimos)
    local y_rel_deimos = radio_T2deimos*math.sin(angulo_deimos)

    luna_deimos.x = marte.x + x_rel_deimos
    luna_deimos.y = marte.y + y_rel_deimos
    
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
Runtime:addEventListener("enterFrame",move)

return scene