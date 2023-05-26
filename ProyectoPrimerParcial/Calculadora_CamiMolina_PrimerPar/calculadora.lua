local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local valor1 = ""
    local valor2 = ""
    local operacion = ""
    local resultado = 0

    local function suma()
        resultado = tonumber(valor1) + tonumber(valor2)
    end

    local function resta()
        resultado = tonumber(valor1) - tonumber(valor2)
    end

    local function multiplicacion()
        resultado = tonumber(valor1) * tonumber(valor2)
    end

    local function division()
        if tonumber(valor2) ~= 0 then
            resultado = tonumber(valor1) / tonumber(valor2)
        else
            resultado = "Error: División por cero"
        end
    end

    local function puntoDecimal()
        if operacion == "" then
            if not string.find(valor1, "%.") then
                valor1 = valor1 .. "."
            end
        else
            if not string.find(valor2, "%.") then
                valor2 = valor2 .. "."
            end
        end
    end

    local function raizCuadrada()
        resultado = math.sqrt(tonumber(valor1))
    end

    local function redondeo()
        resultado = math.round(tonumber(valor1))
    end

    local function potenciaCuadrada()
        resultado = tonumber(valor1) ^ 2
    end

    local function potenciaN()
        resultado = tonumber(valor1) ^ tonumber(valor2)
    end

    local function modulo()
        resultado = tonumber(valor1) % tonumber(valor2)
    end

    local function logaritmoBase10()
        resultado = math.log10(tonumber(valor1))
    end

    local function invertirSigno()
        resultado = tonumber(valor1) * -1
    end

    local function botonPresionado(event)
        local id = event.target.id
        local texto = event.target.text

        if id == "numero" then
            if operacion == "" then
                valor1 = valor1 .. texto
            else
                valor2 = valor2 .. texto
            end
        elseif id == "operacion" then
            if valor1 ~= "" and valor2 ~= "" then
                if operacion == "+" then
                    suma()
                elseif operacion == "-" then
                    resta()
                elseif operacion == "*" then
                    multiplicacion()
                elseif operacion == "/" then
                    division()
                elseif operacion == "√" then
                    raizCuadrada()
                elseif operacion == "R" then
                    redondeo()
                elseif operacion == "^2" then
                    potenciaCuadrada()
                elseif operacion == "^N" then
                    potenciaN()
                elseif operacion == "%" then
                    modulo()
                elseif operacion == "log" then
                    logaritmoBase10()
                elseif operacion == "±" then
                    invertirSigno()
                end

                valor1 = tostring(resultado)
                valor2 = ""
            end

            operacion = texto

            if valor1 ~= "" and valor2 ~= "" then
                if operacion == "." then
                    puntoDecimal()
                end

                valor1 = tostring(resultado)
                valor2 = ""
            end
        elseif id == "resultado" then
            if valor1 ~= "" and valor2 ~= "" then
                if operacion == "+" then
                    suma()
                elseif operacion == "-" then
                    resta()
                elseif operacion == "*" then
                    multiplicacion()
                elseif operacion == "/" then
                    division()
                elseif operacion == "√" then
                    raizCuadrada()
                elseif operacion == "R" then
                    redondeo()
                elseif operacion == "^2" then
                    potenciaCuadrada()
                elseif operacion == "^N" then
                    potenciaN()
                elseif operacion == "%" then
                    modulo()
                elseif operacion == "log" then
                    logaritmoBase10()
                elseif operacion == "±" then
                    invertirSigno()
                end

                valor1 = tostring(resultado)
                valor2 = ""
                operacion = ""
            end
        elseif id == "limpiar" then
            valor1 = ""
            valor2 = ""
            operacion = ""
            resultado = 0
        end

        -- Actualizar los objetos de texto con los nuevos valores
        self.txtValor1.text = valor1
        self.txtValor2.text = valor2
        self.txtResultado.text = tostring(resultado)
    end

    local x = display.contentCenterX
    local y = display.contentCenterY

    local txtValor1 = display.newText({
        text = valor1,
        x = x + 130,
        y = y - 200,
        font = native.systemFontBold,
        fontSize = 50
    })
    txtValor1:setFillColor(1)
    sceneGroup:insert(txtValor1)

    local txtValor2 = display.newText({
        text = valor2,
        x = x + 130,
        y = y - 160,
        font = native.systemFontBold,
        fontSize = 50
    })
    txtValor2:setFillColor(1)
    sceneGroup:insert(txtValor2)

    local txtResultado = display.newText({
        text = tostring(resultado),
        x = x + 130,
        y = y - 120,
        font = native.systemFontBold,
        fontSize = 50
    })
    txtResultado:setFillColor(1)
    sceneGroup:insert(txtResultado)

    local botones = {
        {id = "numero", text = "1", x = x - 50, y = y + 120},
        {id = "numero", text = "2", x = x + 10, y = y + 120},
        {id = "numero", text = "3", x = x + 70, y = y + 120},
        {id = "numero", text = "4", x = x - 50, y = y + 60},
        {id = "numero", text = "5", x = x + 10, y = y + 60},
        {id = "numero", text = "6", x = x + 70, y = y + 60},
        {id = "numero", text = "7", x = x - 50, y = y + 0},
        {id = "numero", text = "8", x = x + 10, y = y + 0},
        {id = "numero", text = "9", x = x + 70, y = y + 0},
        {id = "numero", text = "0", x = x + 10, y = y + 180},
        {id = "operacion", text = ".", x = x - 50, y = y + 180}, 
        {id = "operacion", text = "+", x = x + 130, y = y + 180},
        {id = "operacion", text = "-", x = x + 130, y = y + 120},
        {id = "operacion", text = "*", x = x + 130, y = y + 60},
        {id = "operacion", text = "/", x = x + 130, y = y + 0},
        {id = "resultado", text = "=", x = x + 70, y = y + 180},
        {id = "limpiar", text = "C", x = x - 110, y = y + 180},
        {id = "operacion", text = "√", x = x - 110, y = y + 0}, 
        {id = "operacion", text = "R", x = x - 110, y = y - 60}, 
        {id = "operacion", text = "^2", x = x + 10, y = y - 60}, 
        {id = "operacion", text = "^N", x = x + 70, y = y - 60}, 
        {id = "operacion", text = "%", x = x - 110, y = y + 60}, 
        {id = "operacion", text = "log", x = x - 50, y = y -60}, 
        {id = "operacion", text = "±", x = x - 110, y = y + 120}, 

    }

      for i = 1, #botones do
        local boton = display.newRect(botones[i].x, botones[i].y, 60, 40)
        boton:setFillColor(0.5)
        sceneGroup:insert(boton)

        local textoBoton = display.newText({
            text = botones[i].text,
            x = botones[i].x,
            y = botones[i].y,
            font = native.systemFontBold,
            fontSize = 20
        })
        sceneGroup:insert(textoBoton)

        boton.id = botones[i].id
        boton.text = botones[i].text
        boton:addEventListener("tap", botonPresionado)
    end

    self.txtValor1 = txtValor1
    self.txtValor2 = txtValor2
    self.txtResultado = txtResultado
end

scene:addEventListener("create", scene)

return scene
