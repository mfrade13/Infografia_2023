-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
--display.setDefault("background", 0.6, 0.8, 1)
local widget = require("widget")

-- Función para manejar el evento de cambio de texto en el cuadro de texto
local function onTextChanged(event)
    if (event.phase == "began") then
        -- Se ejecuta cuando se inicia la edición del cuadro de texto
        print("Comenzó la edición del texto")
    elseif (event.phase == "ended" or event.phase == "submitted") then
        -- Se ejecuta cuando se finaliza la edición del cuadro de texto o se presiona el botón de retorno
        print("Texto ingresado: " .. event.target.text)
        -- Limpiar el contenido del cuadro de texto
        event.target.text = ""
    --elseif (event.phase == "submitted" or event.phase == "ended") then
        -- Cuando se presiona Enter o se finaliza la edición
    --    event.target.text = event.target.text .. "\n" -- Agregar un salto de línea
    elseif (event.phase == "editing") then
        -- Se ejecuta mientras se edita el cuadro de texto
        -- Puedes realizar acciones adicionales mientras el usuario escribe
    end
end



-- Crear el cuadro de texto
local textBoxHeight = 50
local textBox = native.newTextField(display.contentCenterX, textBoxHeight, display.contentWidth, textBoxHeight)
textBox.isHitTestable = true -- Permitir edición del texto
--textBox.isMultiline = true -- Permitir múltiples líneas
textBox.align = "right" -- Alinear el texto en la parte derecha
textBox:addEventListener("userInput", onTextChanged)
-- Ajustar el tamaño de la fuente del cuadro de texto
textBox.size = 35 -- Tamaño de fuente en puntos

local textResult = native.newTextField(display.contentCenterX, textBoxHeight * 2, display.contentWidth, textBoxHeight)
textResult.isEditable = false -- No Permitir edición del texto 
textResult.align = "right" -- Alinear el texto en la parte derecha

--Botones
local Botones = {
    {'sinx', '%', 'log10', 'ln', 'C'},
    {'cosx', 'x^y', 'x^2', 'raiz2', '/'},
    {'tanx', '7', '8', '9', '*'},
    {'logn', '4', '5', '6', '-'},
    {'mod', '1', '2', '3', '+',},
    {'red', '+/-', '0', '.', '='}
}


-- Función para evaluar una operación entre dos números
local function evaluarOperacion(num1, num2, operacion)
    if operacion == "+" then
        return num1 + num2
    elseif operacion == "-" then
        return num1 - num2
    elseif operacion == "*" or operacion == "+/-" then
        return num1 * num2
    elseif operacion == "/" then
        return num1 / num2
    elseif operacion == "^" then
        return num1 ^ num2
    elseif operacion == "R2" then
        return num1 ^ (1/num2)
    elseif operacion == "mod" then
        return num1 % num2
    elseif operacion == "log" then
        return math.log(num1) / math.log(num2)--Resulta que math.log era logaritmo natural...
    elseif operacion == "ln" then
        return math.log(num1)
    elseif operacion == "sin" then
        return math.sin(num1)
    elseif operacion == "cos" then
        return math.cos(num1)
    elseif operacion == "tan" then
        return math.tan(num1)
    elseif operacion == "%" then
        return num1 * (num2 / 100)
    elseif operacion == "red" then
        return math.round(num1)
    end
end

-- Función recursiva para evaluar la expresión matemática
local function evaluarExpresion(numeros, operaciones)
    --Realizar todas las potencias y raices primero
    local indexPotencia = nil
    local indexRaiz = nil

    for i, operacion in ipairs(operaciones) do
        if operacion == "^" then
            indexPotencia = i
            break
        elseif operacion == "R2" then
            indexRaiz = i
            break 
        end
    end

    if indexPotencia or indexRaiz then
        local index = indexPotencia or indexRaiz
        local num1 = numeros[index]
        local num2 = numeros[index + 1]
        local operacion = operaciones[index]

        local resultado = evaluarOperacion(num1, num2, operacion)

        -- Remover los números y operaciones utilizados para la potencia o raiz
        table.remove(numeros, index)
        table.remove(numeros, index)
        table.remove(operaciones, index)

        -- Insertar el resultado de la potencia o raiz en la lista de números
        table.insert(numeros, index, resultado)

        -- Llamar recursivamente a la función con las nuevas listas
        return evaluarExpresion(numeros, operaciones)
    end

    --Realizar todas las operaciones trigonometricas y logaritmos primero
    local indexlog = nil
    local indexln = nil
    local indexsin = nil
    local indexcos = nil
    local indextan = nil

    for i, operacion in ipairs(operaciones) do
        if operacion == "log" then
            indexlog = i
            break
        elseif operacion == "ln" then
            indexln = i
            break
        elseif operacion == "sin" then
            indexsin = i
            break
        elseif operacion == "cos" then
            indexcos = i
            break
        elseif operacion == "tan" then
            indextan = i
            break
        end
    end

    if indexlog or indexsin or indexcos or indextan or indexln then
        local index = indexlog or indexsin or indexcos or indextan or indexln
        local num1 = numeros[index]
        local num2 = numeros[index + 1]
        local operacion = operaciones[index]

        local resultado = evaluarOperacion(num1, num2, operacion)

        -- Remover los números y operaciones utilizados para las operaciones trigonometricas y logaritmos
        table.remove(numeros, index)
        table.remove(numeros, index)
        table.remove(operaciones, index)

        -- Insertar el resultado de operaciones trigonometricas y logaritmos en la lista de números
        table.insert(numeros, index, resultado)

        -- Llamar recursivamente a la función con las nuevas listas
        return evaluarExpresion(numeros, operaciones)
    end


    -- Realizar todas las multiplicaciones y divisiones primero
    local indexMultiplicacion = nil
    local indexDivision = nil

    for i, operacion in ipairs(operaciones) do
        if operacion == "*" then
            indexMultiplicacion = i
            break
        elseif operacion == "/" then
            indexDivision = i
            break
        end
    end

    if indexMultiplicacion or indexDivision then
        local index = indexMultiplicacion or indexDivision
        local num1 = numeros[index]
        local num2 = numeros[index + 1]
        local operacion = operaciones[index]

        local resultado = evaluarOperacion(num1, num2, operacion)

        -- Remover los números y operaciones utilizados para la multiplicación o división
        table.remove(numeros, index)
        table.remove(numeros, index)
        table.remove(operaciones, index)

        -- Insertar el resultado de la multiplicación o división en la lista de números
        table.insert(numeros, index, resultado)

        -- Llamar recursivamente a la función con las nuevas listas
        return evaluarExpresion(numeros, operaciones)
    end

    -- Si no quedan multiplicaciones ni divisiones, realizar las sumas y restas
    while #numeros > 1 do
        local num1 = numeros[1]
        local num2 = numeros[2]
        local operacion = operaciones[1]

        local resultado = evaluarOperacion(num1, num2, operacion)

        -- Remover los números y operaciones utilizados para la suma o resta
        table.remove(numeros, 1)
        table.remove(numeros, 1)
        table.remove(operaciones, 1)

        -- Insertar el resultado de la suma o resta en la lista de números
        table.insert(numeros, 1, resultado)
    end

    -- Devolver el resultado final
    return numeros[1]
end


local nums = {}
local ops = {}
local op
-- Función para manejar el evento de clic en los botones
local function handleButtonEvent(event)
    local buttonValue = event.target:getLabel() -- Obtener el valor del botón clicado
    
    -- Realizar acciones según el valor del botón
    if buttonValue == "0" then
        -- Concatenar "0" al contenido del cuadro de texto
        textBox.text = textBox.text .. "0"
        textResult.text = textResult.text .. "0"
    elseif buttonValue == "1" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "1"
        textResult.text = textResult.text .. "1"
    elseif buttonValue == "2" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "2"
        textResult.text = textResult.text .. "2"
    elseif buttonValue == "3" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "3"
        textResult.text = textResult.text .. "3"
    elseif buttonValue == "4" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "4"
        textResult.text = textResult.text .. "4"
    elseif buttonValue == "5" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "5"
        textResult.text = textResult.text .. "5"
    elseif buttonValue == "6" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "6"
        textResult.text = textResult.text .. "6"
    elseif buttonValue == "7" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "7"
        textResult.text = textResult.text .. "7"
    elseif buttonValue == "8" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "8"
        textResult.text = textResult.text .. "8"
    elseif buttonValue == "9" then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "9"
        textResult.text = textResult.text .. "9"
    elseif buttonValue == "." then
        -- Concatenar "1" al contenido del cuadro de texto
        textBox.text = textBox.text .. "."
        textResult.text = textResult.text .. "."
    elseif buttonValue == "+" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "+"
        table.insert(nums, tonumber(textBox.text))
        --print(num1)
        textBox.text = ""
        table.insert(ops, "+")
        --op = 1
    elseif buttonValue == "-" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "-"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 2
        table.insert(ops, "-")
    elseif buttonValue == "*" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "*"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 3
        table.insert(ops, "*")
    elseif buttonValue == "/" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "/"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 4
        table.insert(ops, "/")
    elseif buttonValue == "x^y" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "^"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 6
        table.insert(ops, "^")
    elseif buttonValue == "x^2" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "^2"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 7 
        table.insert(ops, "^")
        table.insert(nums, 2)
    elseif buttonValue == "raiz2" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "^(1/2)"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 9
        table.insert(ops, "R2")
        table.insert(nums, 2)
    elseif buttonValue == "mod" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "mod"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 14
        table.insert(ops, "mod")
    elseif buttonValue == "logn" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "log"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 8
        table.insert(ops, "log")
    elseif buttonValue == "log10" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "log10"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 10
        table.insert(ops, "log")
        table.insert(nums, 10)
    elseif buttonValue == "logn" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "log"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 10
        table.insert(ops, "log")
    elseif buttonValue == "ln" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "ln"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 10
        table.insert(ops, "ln")
        table.insert(nums, 1)
    elseif buttonValue == "+/-" then
        textResult.text = textResult.text .. "(-1)"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 5
        table.insert(ops, "+/-")
        table.insert(nums, -1)
    elseif buttonValue == "sinx" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "sin"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 11
        table.insert(ops, "sin")
        table.insert(nums, 1)
    elseif buttonValue == "cosx" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "cos"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 12
        table.insert(ops, "cos")
        table.insert(nums, 1)
    elseif buttonValue == "tanx" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "tan"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 13
        table.insert(ops, "tan")
        table.insert(nums, 1)
    elseif buttonValue == "%" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "%"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 5
        table.insert(ops, "%")
    elseif buttonValue == "red" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        textResult.text = textResult.text .. "red"
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        --op = 15
        table.insert(ops, "red")
        table.insert(nums, 1)
    elseif buttonValue == "C" then
        textResult.text = ""
        textBox.text = ""
        nums = {}
        ops = {}
    elseif buttonValue == "=" then
        -- Realizar el cálculo de la expresión matemática ingresada y mostrar el resultado
        --textResult.text = textResult.text .. ""
        local resultado = nil
        table.insert(nums, tonumber(textBox.text))
        textBox.text = ""
        for i, elemento in ipairs(nums) do
            print("nums: " .. elemento)
        end
        for i, elemento in ipairs(ops) do
            print("ops: " .. elemento)
        end
        resultado = evaluarExpresion(nums, ops)
        textResult.text = tostring(resultado)
        nums = {}
        ops = {}
    end
end

local function onTouch(event)
    if event.phase == "ended" then
        handleButtonEvent(event)
    end
    return true
end

-- Crear los botones
local buttonWidth = 40
local buttonHeight = 40
local buttonMargin = 20
local startX = display.contentCenterX - (buttonWidth * 2 + buttonMargin) -- Alinear los botones al centro horizontal
local startY = textResult.y + textBoxHeight-- + buttonMargin  -- Ajustar la posición vertical debajo del cuadro de texto

for i = 1, #Botones do
    local row = Botones[i]
    for j = 1, #row do
        local buttonLabel = row[j]
        
        local button = widget.newButton({
            x = (startX + (j - 1) * (buttonWidth + buttonMargin)) - buttonWidth / 2.5,
            y = startY + (i - 1) * (buttonHeight + buttonMargin),
            width = buttonWidth,
            height = buttonHeight,
            label = buttonLabel,
            onEvent = onTouch
            --strokeWidth = 5,
            --strokeColor = { 255, 255, 255 }
        })
    end
end


