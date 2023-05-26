--64 ancho 80 alto



local borderRadius = 10
-- Crear el botón cuadrado
local boton0 = display.newRoundedRect(20, 445, 60, 60, borderRadius)
boton0:setFillColor(0.5, 0.5, 0.5)
boton0.strokeWidth = 1
local texto0 = display.newText({
    text = "0",
    x = boton0.x,
    y = boton0.y,
    font = native.systemFont,
    fontSize = 20
})

local botonpunto = display.newRoundedRect(90, 445, 60, 60, borderRadius)
botonpunto:setFillColor(0.5, 0.5, 0.5)
local textopunto = display.newText({
    text = ".",
    x = botonpunto.x,
    y = botonpunto.y,
    font = native.systemFont,
    fontSize = 40
})

local botonigual = display.newRoundedRect(160, 445, 60, 60, borderRadius)
botonigual:setFillColor(0/255, 204/255, 102/255)
local textoigual = display.newText({
    text = "=",
    x = botonigual.x,
    y = botonigual.y,
    font = native.systemFont,
    fontSize = 20
})

local botonac = display.newRoundedRect(230, 445, 60, 60, borderRadius)
botonac:setFillColor(255/255, 80/255, 80/255)
local textoac = display.newText({
    text = "AC",
    x = botonac.x,
    y = botonac.y,
    font = native.systemFont,
    fontSize = 20
})

local botondel = display.newRoundedRect(300, 445, 60, 60, borderRadius)
botondel:setFillColor(255/255, 153/255, 51/255)
local textodel = display.newText({
    text = "DEL",
    x = botondel.x,
    y = botondel.y,
    font = native.systemFont,
    fontSize = 20
})


local boton1 = display.newRoundedRect(20, 380, 60, 60, borderRadius)
boton1:setFillColor(0.5, 0.5, 0.5)
boton1.strokeWidth = 1
local texto1 = display.newText({
    text = "1",
    x = boton1.x,
    y = boton1.y,
    font = native.systemFont,
    fontSize = 20
})
local boton2 = display.newRoundedRect(90, 380, 60, 60, borderRadius)
boton2:setFillColor(0.5, 0.5, 0.5)
boton2.strokeWidth = 1
local texto2 = display.newText({
    text = "2",
    x = boton2.x,
    y = boton2.y,
    font = native.systemFont,
    fontSize = 20
})

local boton3 = display.newRoundedRect(160, 380, 60, 60, borderRadius)
boton3:setFillColor(0.5, 0.5, 0.5)
boton3.strokeWidth = 1
local texto3 = display.newText({
    text = "3",
    x = boton3.x,
    y = boton3.y,
    font = native.systemFont,
    fontSize = 20
})

local botonred = display.newRoundedRect(230, 380, 60, 60, borderRadius)
botonred:setFillColor(0.5, 0.5, 0.5)
local textored = display.newText({
    text = "redondeo",
    x = botonred.x,
    y = botonred.y,
    font = native.systemFont,
    fontSize = 10
})

local botonneg = display.newRoundedRect(300, 380, 60, 60, borderRadius)
botonneg:setFillColor(0.5, 0.5, 0.5)
local textoneg = display.newText({
    text = "+/-",
    x = botonneg.x,
    y = botonneg.y,
    font = native.systemFont,
    fontSize = 20
})

local boton4 = display.newRoundedRect(20, 315, 60, 60, borderRadius)
boton4:setFillColor(0.5, 0.5, 0.5)
boton4.strokeWidth = 1
local texto4 = display.newText({
    text = "4",
    x = boton4.x,
    y = boton4.y,
    font = native.systemFont,
    fontSize = 20
})

local boton5 = display.newRoundedRect(90, 315, 60, 60, borderRadius)
boton5:setFillColor(0.5, 0.5, 0.5)
boton5.strokeWidth = 1
local texto5 = display.newText({
    text = "5",
    x = boton5.x,
    y = boton5.y,
    font = native.systemFont,
    fontSize = 20
})

local boton6 = display.newRoundedRect(160, 315, 60, 60, borderRadius)
boton6:setFillColor(0.5, 0.5, 0.5)
boton6.strokeWidth = 1
local texto6 = display.newText({
    text = "6",
    x = boton6.x,
    y = boton6.y,
    font = native.systemFont,
    fontSize = 20
})

local botonmas = display.newRoundedRect(230, 315, 60, 60, borderRadius)
botonmas:setFillColor(0.5, 0.5, 0.5)
local textomas = display.newText({
    text = "+",
    x = botonmas.x,
    y = botonmas.y,
    font = native.systemFont,
    fontSize = 25
})

local botonmenos = display.newRoundedRect(300, 315, 60, 60, borderRadius)
botonmenos:setFillColor(0.5, 0.5, 0.5)
local textomenos = display.newText({
    text = "-",
    x = botonmenos.x,
    y = botonmenos.y,
    font = native.systemFont,
    fontSize = 35
})


local boton7 = display.newRoundedRect(20, 250, 60, 60, borderRadius)
boton7:setFillColor(0.5, 0.5, 0.5)
boton7.strokeWidth = 1
local texto7 = display.newText({
    text = "7",
    x = boton7.x,
    y = boton7.y,
    font = native.systemFont,
    fontSize = 20
})

local boton8 = display.newRoundedRect(90, 250, 60, 60, borderRadius)
boton8:setFillColor(0.5, 0.5, 0.5)
boton8.strokeWidth = 1
local texto8 = display.newText({
    text = "8",
    x = boton8.x,
    y = boton8.y,
    font = native.systemFont,
    fontSize = 20
})

local boton9 = display.newRoundedRect(160, 250, 60, 60, borderRadius)
boton9:setFillColor(0.5, 0.5, 0.5)
boton9.strokeWidth = 1
local texto9 = display.newText({
    text = "9",
    x = boton9.x,
    y = boton9.y,
    font = native.systemFont,
    fontSize = 20
})

local botonmult = display.newRoundedRect(230, 250, 60, 60, borderRadius)
botonmult:setFillColor(0.5, 0.5, 0.5)
local textomult = display.newText({
    text = "x",
    x = botonmult.x,
    y = botonmult.y,
    font = native.systemFont,
    fontSize = 20
})

local botondiv = display.newRoundedRect(300, 250, 60, 60, borderRadius)
botondiv:setFillColor(0.5, 0.5, 0.5)
local textodiv = display.newText({
    text = "÷",
    x = botondiv.x,
    y = botondiv.y,
    font = native.systemFont,
    fontSize = 30
})

local botonlog = display.newRoundedRect(20, 185, 60, 60, borderRadius)
botonlog:setFillColor(0.5, 0.5, 0.5)
local textolog = display.newText({
    text = "log()",
    x = botonlog.x,
    y = botonlog.y,
    font = native.systemFont,
    fontSize = 15
})


local botoncuadrado = display.newRoundedRect(90, 185, 60, 60, borderRadius)
botoncuadrado:setFillColor(0.5, 0.5, 0.5)
local textocuadrado = display.newText({
    text = "x²",
    x = botoncuadrado.x,
    y = botoncuadrado.y,
    font = native.systemFont,
    fontSize = 15
})

local botonmenos1 = display.newRoundedRect(160, 185, 60, 60, borderRadius)
botonmenos1:setFillColor(0.5, 0.5, 0.5)
local textomenos1 = display.newText({
    text = "x ⁻¹",
    x = botonmenos1.x,
    y = botonmenos1.y,
    font = native.systemFont,
    fontSize = 15
})

local botonalan = display.newRoundedRect(230, 185, 60, 60, borderRadius)
botonalan:setFillColor(0.5, 0.5, 0.5)
local textoalan = display.newText({
    text = "xⁿ",
    x = botonalan.x,
    y = botonalan.y,
    font = native.systemFont,
    fontSize = 15
})

local botonraiz = display.newRoundedRect(300, 185, 60, 60, borderRadius)
botonraiz:setFillColor(0.5, 0.5, 0.5)
local textoraiz = display.newText({
    text = "√",
    x = botonraiz.x,
    y = botonraiz.y,
    font = native.systemFont,
    fontSize = 20
})


local botonsen = display.newRoundedRect(20, 120, 60, 60, borderRadius)
botonsen:setFillColor(0.5, 0.5, 0.5)
local textosen = display.newText({
    text = "sen()",
    x = botonsen.x,
    y = botonsen.y,
    font = native.systemFont,
    fontSize = 15
})

local botoncos = display.newRoundedRect(90, 120, 60, 60, borderRadius)
botoncos:setFillColor(0.5, 0.5, 0.5)
local textocos = display.newText({
    text = "cos()",
    x = botoncos.x,
    y = botoncos.y,
    font = native.systemFont,
    fontSize = 15
})

local botontan = display.newRoundedRect(160, 120, 60, 60, borderRadius)
botontan:setFillColor(0.5, 0.5, 0.5)
local textotan = display.newText({
    text = "tan()",
    x = botontan.x,
    y = botontan.y,
    font = native.systemFont,
    fontSize = 15
})

local botonmod = display.newRoundedRect(230, 120, 60, 60, borderRadius)
botonmod:setFillColor(0.5, 0.5, 0.5)
local textomod = display.newText({
    text = "modulo",
    x = botonmod.x,
    y = botonmod.y,
    font = native.systemFont,
    fontSize = 10
})

local botonpi = display.newRoundedRect(300, 120, 60, 60, borderRadius)
botonpi:setFillColor(0.5, 0.5, 0.5)
local textopi = display.newText({
    text = "π",
    x = botonpi.x,
    y = botonpi.y,
    font = native.systemFont,
    fontSize = 20
})


local resultado = display.newText({
    text = "",
    x = 10,
    y = 30,
    font = native.systemFont,
    fontSize = 20
})
local res = resultado.text

local ans = display.newText({
    text = "0",
    x = 320,
    y = 60,
    font = native.systemFont,
    fontSize = 20
})

resultado.anchorX=0
ans.anchorX=320

-- Función para manejar el evento de toque en el botón
local function boton1Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .. "1"
    end
end

local function boton2Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."2"
    end
end

local function boton3Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."3"
    end
end

local function boton4Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."4"
    end
end

local function boton5Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."5"
    end
end

local function boton6Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."6"
    end
end

local function boton7Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."7"
    end
end

local function boton8Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."8"
    end
end

local function boton9Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."9"
    end
end

local function boton0Presionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."0"
    end
end

local function botonmasPresionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."+"
    end
end

local function botonmenosPresionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."-"
    end
end

local function botonpuntoPresionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."."
    end
end

local function botonmultPresionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."*"
    end
end

local function botondivPresionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."/"
    end
end

local function botonacPresionado(event)
    if event.phase == "ended" then
        resultado.text = ""
        ans.text = "0"
    end
end

local function botondelPresionado(event)
    if event.phase == "ended" then
        resultado.text = string.sub(resultado.text,1,-2);
    end
end

local function botonredPresionado(event)
    if event.phase == "ended" then
        local resred= loadstring("return " .. resultado.text)()
        ans.text = math.round(resred)
        --local ansresred = math.round(tonumber(resred));
        --ans.text = ansresred
    end
end

local function botonnegPresionado(event)
    if event.phase == "ended" then
        local resmenos1= loadstring("return " .. resultado.text)()
        ans.text = resmenos1 * (-1)
    end
end

local function botonraizPresionado(event)
    if event.phase == "ended" then
        local resraiz= loadstring("return " .. resultado.text)()
        ans.text = math.sqrt(resraiz)
    end
end

local function botonlogPresionado(event)
    if event.phase == "ended" then
        local reslog= loadstring("return " .. resultado.text)()
        ans.text = math.log10(reslog)
    end
end

local function botoncuadradoPresionado(event)
    if event.phase == "ended" then
        local rescuadrado= loadstring("return " .. resultado.text)()
        ans.text = math.pow(rescuadrado,2);
    end
end

local function botonmenos1Presionado(event)
    if event.phase == "ended" then
        local resmenos1= loadstring("return " .. resultado.text)()
        ans.text = math.pow(resmenos1,(-1));
    end
end

local function botonalanPresionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."^"
    end
end

local function botonsenPresionado(event)
    if event.phase == "ended" then
        local ressen= loadstring("return " .. resultado.text)()
        ans.text = math.sin(ressen);
    end
end

local function botoncosPresionado(event)
    if event.phase == "ended" then
        local rescos= loadstring("return " .. resultado.text)()
        ans.text = math.cos(rescos);
    end
end

local function botontanPresionado(event)
    if event.phase == "ended" then
        local restan= loadstring("return " .. resultado.text)()
        ans.text = math.tan(restan);
    end
end

local function botonmodPresionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."%"
    end
end

local function botonpiPresionado(event)
    if event.phase == "ended" then
        resultado.text = resultado.text .."3.141592654"
    end
end

local function botonigualPresionado(event)
    if event.phase == "ended" then
        local res = resultado.text
        local resultadoOperacion = loadstring("return " .. res)()
        ans.text = resultadoOperacion
    end
end

-- Asignar la función de manejo de eventos a los botones
boton1:addEventListener("touch", boton1Presionado)
boton2:addEventListener("touch", boton2Presionado)
boton3:addEventListener("touch", boton3Presionado)
boton4:addEventListener("touch", boton4Presionado)
boton5:addEventListener("touch", boton5Presionado)
boton6:addEventListener("touch", boton6Presionado)
boton7:addEventListener("touch", boton7Presionado)
boton8:addEventListener("touch", boton8Presionado)
boton9:addEventListener("touch", boton9Presionado)
boton0:addEventListener("touch", boton0Presionado)
botonmas:addEventListener("touch", botonmasPresionado)
botonigual:addEventListener("touch", botonigualPresionado)
botonmenos:addEventListener("touch", botonmenosPresionado)
botonpunto:addEventListener("touch", botonpuntoPresionado)
botonmult:addEventListener("touch", botonmultPresionado)
botondiv:addEventListener("touch", botondivPresionado)
botonac:addEventListener("touch", botonacPresionado)
botondel:addEventListener("touch", botondelPresionado)
botonred:addEventListener("touch", botonredPresionado)
botonneg:addEventListener("touch", botonnegPresionado)
botonraiz:addEventListener("touch", botonraizPresionado)
botonlog:addEventListener("touch", botonlogPresionado)
botoncuadrado:addEventListener("touch", botoncuadradoPresionado)
botonmenos1:addEventListener("touch", botonmenos1Presionado)
botonalan:addEventListener("touch", botonalanPresionado)
botonsen:addEventListener("touch", botonsenPresionado)
botonsen:addEventListener("touch", botonsenPresionado)
botoncos:addEventListener("touch", botoncosPresionado)
botontan:addEventListener("touch", botontanPresionado)
botonmod:addEventListener("touch", botonmodPresionado)
botonpi:addEventListener("touch", botonpiPresionado)


