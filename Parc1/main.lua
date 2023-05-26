local CW = display.contentWidth
local CH = display.contentHeight
display.setStatusBar(display.DarkStatusBar)

local ACW = display.actualContentWidth
local ACH = display.actualContentHeight
local fondo = display.newImageRect("assets/fondo2.jpg", CW, CH)
fondo.x = CW/2; fondo.y = CH/2; fondo:toBack()



local matrizCeldas = {}
local numFilas = 6
local numColumnas = 5
local celdaSize = 40
local celdaSeparacion = 3
local celdaColor = { 1, 1, 1 }
local celdaBorde = { 0, 0, 0 }
local startX = 74
local startY = 40
function matCeldas()
	for fila = 1, numFilas do
	    matrizCeldas[fila] = {}
	    for columna = 1, numColumnas do
	        local celdaX = startX + (columna - 1) * (celdaSize + celdaSeparacion)
	        local celdaY = startY + (fila - 1) * (celdaSize + celdaSeparacion)
	        local celda = display.newRect(celdaX, celdaY, celdaSize, celdaSize)
	        celda:setFillColor(unpack(celdaColor))
	        celda.strokeWidth = 2
	        celda:setStrokeColor(unpack(celdaBorde))
	        matrizCeldas[fila][columna] = celda
	    end
	end
end
matCeldas()

local intento = 1
function tocar_teclas(self, event)
    if event.phase == "ended" then
        print("Evento en la tecla " .. self.nombre)

        for columna = 1, numColumnas do
            local celda = matrizCeldas[intento][columna]
            if not celda.text then -- Verificar si la celda no tiene texto
                celda.text = self.nombre -- Asignar el nombre de la tecla a la celda
                
                local labelTextOptions = {
                    text = self.nombre,
                    x = celda.x,
                    y = celda.y,
                    width = celdaSize,
                    height = celdaSize,
                    font = native.systemFont,
                    fontSize = 25,
                    align = "center",
                    anchorY = 0.5
                }
                celda.label = display.newText(labelTextOptions)
                celda.label:setFillColor(0)
                celda.label.anchorY = 0.35
                return -- Salir de la función después de asignar la tecla a una celda
            end
        end
    end
    return true
end


local fila1 = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"}
local fila2 = {"A", "S", "D", "F", "G", "H", "J", "K", "L", "Ñ"}
local fila3 = {"Z", "X", "C", "V", "B", "N", "M"}
local matrizTeclado = {}
local filasTeclado = {fila1, fila2, fila3}
local teclaSize = 25
local teclaSeparacion = 5
local teclaColor = {0.7, 0.7, 0.7}
local teclaBordeColor = {0.2, 0.2, 0.2}
local startX = 30
local startY = 350

function crearTeclado()
	for fila = 1, #filasTeclado do
		matrizTeclado[fila] = {}
	    for columna = 1, #filasTeclado[fila] do
	        local teclaX = startX + (columna - 1) * (teclaSize + teclaSeparacion)
	        local teclaY = startY + (fila - 1) * (teclaSize + teclaSeparacion)
	        local tecla = display.newRect(teclaX, teclaY, teclaSize, teclaSize)
	        tecla:setFillColor(unpack(teclaColor))
	        tecla.strokeWidth = 1
	        tecla:setStrokeColor(unpack(teclaBordeColor))
	        matrizTeclado[fila][columna] = tecla

	        local labelText = filasTeclado[fila][columna]
	        local labelOptions = {
	            text = labelText,
	            x = teclaX,
	            y = teclaY,
	            width = teclaSize,
	            height = teclaSize,
	            font = native.systemFont,
	            fontSize = 16,
	            align = "center",
	            anchorY = 0.5
	        }
	        local label = display.newText(labelOptions)
	        --label:setFillColor(0)
	        label.anchorY = 0.4
	        tecla.nombre = labelText
	        tecla.touch = tocar_teclas
	        tecla:addEventListener( "touch" )
	    end
	end
end
crearTeclado()

math.randomseed(os.time())

function elegir_palabra_aleatoria(nombre_archivo)
    local path = system.pathForFile(nombre_archivo, system.ResourceDirectory) -- Obtener la ruta completa del archivo
    local file = io.open(path, "r") -- Abrir el archivo en modo lectura
    local lista_palabras = {}

    -- Leer el archivo línea por línea y agregar las palabras a la lista
    for line in file:lines() do
        table.insert(lista_palabras, line)
    end

    -- Generar un número aleatorio dentro del rango válido de índices de la lista de palabras
    local indice_aleatorio = math.random(1, #lista_palabras)

    -- Obtener la palabra correspondiente al índice aleatorio generado
    local palabra_aleatoria = lista_palabras[indice_aleatorio]

    -- Cerrar el archivo
    io.close(file)

    -- Retornar la palabra aleatoria seleccionada
    return palabra_aleatoria
end


local nombre_archivo = "assets/wordList1.txt" 
local palabra_aleatoria = elegir_palabra_aleatoria(nombre_archivo)
print("Palabra aleatoria seleccionada:", palabra_aleatoria)

local maxAttempts = 6
local function borrarCelda(self, event)
    if event.phase == "ended" then
    print("Evento en la tecla " .. self.nombre)
        -- Recorrer las celdas en orden inverso para encontrar la última celda con texto
        for columna = numColumnas, 1, -1 do
            local celda = matrizCeldas[intento][columna]
            if celda.text then -- Verificar si la celda tiene texto
                celda.text = nil -- Borrar el texto de la celda
                celda.label.text = ""
                celda:setFillColor( 1,1,1 )
                return -- Salir de la función después de borrar la celda
            end
        end
    end
    return true
end


function delBtn()
	local del = display.newRect( 300,410,teclaSize,teclaSize )
	del:setFillColor(0.7,0.7,0.7)
	del.strokeWidth = 1
	del:setStrokeColor(0,0,0)
	del.nombre = "DEL"
	del.touch = borrarCelda
	del:addEventListener( "touch" )
	local DelLabelOpt = {text = "DEL",
		            x = 300,
		            y = 410,
					font = native.systemFont,
		            fontSize = 12,
		            align = "center",
		            anchorY = 0.5}
	local DelLab = display.newText( DelLabelOpt )
	DelLab.anchorY = 0.5
end
delBtn()

function verificarPalabraExistente(palabra)
    local path = system.pathForFile("assets/05_cleaned.txt", system.ResourceDirectory) -- Obtener la ruta completa del archivo
    local file = io.open(path, "r") -- Abrir el archivo en modo lectura

    -- Verificar si el archivo se abrió correctamente
    if file then
        -- Leer el archivo línea por línea
        for line in file:lines() do
            -- Comparar la palabra formada con cada línea del archivo diccionario
            if line == palabra then
                -- La palabra existe en el archivo
                io.close(file) -- Cerrar el archivo
                return true
            end
        end

        io.close(file) -- Cerrar el archivo
    end

    -- La palabra no existe en el archivo o hubo un error al abrir el archivo
    return false
end


local function obtenerPalabraFormada()
	local palabraFormada = ""
	for columna = 1, numColumnas do
        local celda = matrizCeldas[intento][columna]
        if celda.text then -- Verificar si la celda no tiene texto
            palabraFormada = palabraFormada .. celda.text 
        end
    end
    return palabraFormada
end

local function Win()
	local newfondo = display.newImageRect("assets/fondo2.jpg", CW, CH)
	newfondo.x = CW/2; newfondo.y = CH/2; 
	local mensajeWin = display.newText("YOU WIN!!", 160,240,"arial",40)
end

local function Lose()
	local newfondo = display.newImageRect("assets/fondo2.jpg", CW, CH)
	newfondo.x = CW/2; newfondo.y = CH/2; 
	local mensajeWin = display.newText("YOU LOSE!!", 160,240,"arial",40)
end


local function coincidencias()
	local palabraFormada = obtenerPalabraFormada()
    local palabra_aleatoria_letras = {}
    local palabraFormada_letras = {}

    -- Convertir la palabra a adivinar en una tabla de letras
    for i = 1, #palabra_aleatoria do
        table.insert(palabra_aleatoria_letras, string.sub(palabra_aleatoria, i, i))
    end

    -- Convertir la palabra formada en una tabla de letras
    for i = 1, #palabraFormada do
        table.insert(palabraFormada_letras, string.sub(palabraFormada, i, i))
    end

    -- Crear una copia de la tabla de letras de la palabra a adivinar
    local letras_restantes = {}
    for i = 1, #palabra_aleatoria_letras do
        table.insert(letras_restantes, palabra_aleatoria_letras[i])
    end

    --Verificar cada letra de la palabra formada
    for i = 1, #palabraFormada_letras do
        local letra = palabraFormada_letras[i]

        -- Verificar si la letra está en la palabra aleatoria
        local index = table.indexOf(letras_restantes, letra)
        if index then
            -- Coincidencia (pintar la celda de amarillo)
            matrizCeldas[intento][i]:setFillColor(1, 1, 0)
            table.remove(letras_restantes, index)
        else--si no rojo
        	matrizCeldas[intento][i]:setFillColor(1, 45/255, 45/255)
        end
    end
end  
    
local function colorTeclas()
	local palabraFormada = obtenerPalabraFormada()
    local palabra_aleatoria_letras = {}
    local palabraFormada_letras = {}

    -- Convertir la palabra a adivinar en una tabla de letras
    for i = 1, #palabra_aleatoria do
        table.insert(palabra_aleatoria_letras, string.sub(palabra_aleatoria, i, i))
    end

    -- Convertir la palabra formada en una tabla de letras
    for i = 1, #palabraFormada do
        table.insert(palabraFormada_letras, string.sub(palabraFormada, i, i))
    end

    -- Crear una copia de la tabla de letras de la palabra a adivinar
    local letras_restantes = {}
    for i = 1, #palabra_aleatoria_letras do
        table.insert(letras_restantes, palabra_aleatoria_letras[i])
    end

	for i = 1, #palabraFormada_letras do
        local letra = palabraFormada_letras[i]

        -- Verificar si la letra está en la palabra a adivinar
        local index = table.indexOf(letras_restantes, letra)
        if not index then-- si no
            -- Coincidencia (pintar la tecla de rojo)
            for fila = 1, #matrizTeclado do
                for columna = 1, #matrizTeclado[fila] do
                    local tecla = matrizTeclado[fila][columna]
                    if tecla.nombre == letra then
                        tecla:setFillColor(250/255, 128/255, 114/255)
                        break
                    end
                end
            end
            -- Eliminar la letra de la tabla de letras restantes
            --table.remove(letras_restantes, index)
        else
            -- hay coincidencia (pintar la tecla de amarillo)
            for fila = 1, #matrizTeclado do
                for columna = 1, #matrizTeclado[fila] do
                    local tecla = matrizTeclado[fila][columna]
                    if tecla.nombre == letra then
                        tecla:setFillColor(253/255, 238/255, 177/255)
                        break
                    end
                end
            end
            table.remove(letras_restantes, index)
        end
    end
end

local function colorVerde()
	for columna = 1, numColumnas do
        local celda = matrizCeldas[intento][columna]
        local letra = celda.text

        if letra then
            local letraCorrecta = false

            -- Verificar si la letra está en la palabra y en la posición correcta
            if letra == string.sub(palabra_aleatoria, columna, columna) then
                letraCorrecta = true
            end

            -- Cambiar el color de la celda según la condición
            if letraCorrecta then
                celda:setFillColor(0, 1, 0) -- Verde si la letra coincide con la palabra
            	-- Cambiar el color de la letra correspondiente en el teclado
	            for fila = 1, #matrizTeclado do
	                for columna = 1, #matrizTeclado[fila] do
	                    local tecla = matrizTeclado[fila][columna]
	                    if tecla.nombre == letra then
	                        tecla:setFillColor(189/255, 236/255, 182/255)
	                        break
	                    end
	                end
	            end
            end
        end
    end
end


local function siguienteIntento()
    local mensaje = display.newText("",160,310,"arial",13)
	local palabraFormada = obtenerPalabraFormada()
	if not verificarPalabraExistente(palabraFormada) then
        print("La palabra "..palabraFormada.." no existe")
        mensaje.text = "La palabra "..palabraFormada.." no existe en el diccionario, \nintenta de nuevo"
        mensaje:setFillColor( 0,0,0 )
        local function borrarMensaje()
            mensaje.text = ""
        end
        -- Programar el borrado del mensaje 
        timer.performWithDelay(3000, borrarMensaje)
    else
        mensaje.text = ""
        colorTeclas()
    	coincidencias()
    	colorVerde()
        intento = intento + 1
		--print(intento)
        if(intento == 7) then 
        	Lose()
        end	
	end
end

function verificarPalabra(self, event)
    local mensaj = display.newText("",160,310,"arial",13)
	if event.phase == "ended" and not matrizCeldas[intento][5].text then
		print("Palabra incompleta")
        mensaj.text = "La palabra debe tener 5 letras"
        mensaj:setFillColor( 0,0,0 )
        local function letrasCant()
            mensaj.text = ""
        end
        -- Programar el borrado del mensaje
        timer.performWithDelay(3000, letrasCant)
		
	elseif event.phase == "ended" and matrizCeldas[intento][5].text then
        print("Evento en la tecla " .. self.nombre)
		print("Palabra completa")
        local palabraFormada = obtenerPalabraFormada()
        print( "Guess: "..palabraFormada )
        print( "Answer:"..palabra_aleatoria)
        if palabraFormada == palabra_aleatoria then
            print("¡Palabra correcta!")
            Win()
	    else
	        print("Palabra incorrecta. Intenta de nuevo.")
	    end
	    
		siguienteIntento()
		print(intento)
	end
end

function sendBtn()
	local send = display.newRect( 255,410,teclaSize* 2+5,teclaSize )
	send:setFillColor(0.7,0.7,0.7)
	send.strokeWidth = 1
	send:setStrokeColor(0,0,0)
	send.nombre = "SEND"
	send.touch = verificarPalabra
	send:addEventListener( "touch" )
	local SendLabelOpt = {text = "SEND",
		            x = 255,
		            y = 410,
					font = native.systemFont,
		            fontSize = 13,
		            align = "center",
		            anchorY = 0.5}
	local sendLab = display.newText( SendLabelOpt )
	sendLab.anchorY = 0.45
end

sendBtn()


