
-- Your code here

print("Ola mundo! da lua")
-- declarar variables con tipos de datos diferentes
variable_booleana = true 
variables_numericas = 123
variables_flotantes = 1232.34

print( variable_booleana, variables_numericas, variables_flotantes )

variable_string = "Cadena de texto"

print( variable_string )

print( type( variables_flotantes ) )

print( type( variables_numericas ) )

print( type( variable_booleana ), type( variable_string ) )

-- Uso de una tabla como una lista
variable_array = {1,2,3,4,5, "cadena", false, nil, 32.43}

print( variable_array )

print( variable_array[3] )

print(variable_array[7])
--Iterar sobre una tabla de una lista
for i,v in ipairs(variable_array) do
	print(i,v)
end

print( variable_array[9] )
--Declarar una tabla como un mapa de llave-valor
variable_mapa = {
	edad = "20",
	estatura = "1.74",
	esta_casado = false,
	nacionalidad = "Boliviana",
	materias_aprobadas = {" progra1", "progra2"}
}

print( variable_mapa["nacionalidad"], variable_mapa.edad )
-- Iterar sobre una tabla de llave valor
for k,v in pairs(variable_mapa) do
	print(k,v)
end

print( #(variable_array) )
-- Iterar con un for 
for i=1, #variable_array, 2 do
	print( variable_array[i] )
end

if tonumber(variable_mapa.edad) >= 18 then
	print( "La persona tiene " .. variable_mapa.edad .. " anhos")
end

if  not(variable_mapa.esta_casado == true) then
	print( "La persona no esta casada" )
else
	print("La persona esta casada")
end

function sumar( a,b )
	return tonumber(a) + tonumber(b)
end

function operar( a,b,c )
	print(c(a,b)  )
end

print( sumar(variable_mapa.edad, variable_mapa.estatura) )

print( type( sumar ))


print(operar( 21,21,sumar ))

function primer_nivel(a, b) 
	function segundo_nivel (a )
		return a*a
	end
	local resultado = segundo_nivel(a)
	return resultado+b
end

print(primer_nivel( 3, 5 ))


function factorial(n)
	if n ==0 then
		return 1
	else
		return n * factorial(n-1)  -- 5 * factorial(4)  .. 5*4 * factorial (3)
 
	end
end

print(factorial(5))

--0, 1,1,2,3,5,8

function fibonacci(n)

	if n <= 0 then
		return 0
	
	elseif n ==1 then
		return 1
	else
		return fibonacci(n-1) + fibonacci(n-2)
	end

end

print(fibonacci(5))
function fibonacci_dp(n)
	local array_fibonacci = {}

	array_fibonacci[1] = 1
	array_fibonacci[2] = 1

	for i=3,n,1 do
		array_fibonacci[i] = array_fibonacci[i-1] + array_fibonacci[i-2] 
	end

	return array_fibonacci[n]

	-- if (n<=1) then
	-- 	return n
	-- elseif (array_fibonacci[n] ) then
	-- 	return array_fibonacci[n]
	-- else 
	-- 	array_fibonacci[n] = fibonacci_dp(n-1) + fibonacci_dp(n-2)
	-- 	return array_fibonacci[n]
	-- end

end

print( (fibonacci_dp (7)) )

--maximo multiplo divisor 25 1,5,5,25 // 48, 1,2,3,4,6,8,12,16,24,48
-- 1 2 2 1
--   i j
function is_prime(n)
	if n % 2 == 0 then
		return false
	end

	for i=3, math.sqrt( n ),2 do
		print(i)
		if n % i == 0 then
			return false
		end
	end
	return true
end

print( is_prime(53))

function is_capicua( n )
	-- tratar numero como string
	local numero_string = tostring( n )
	local longitud = string.len(numero_string)

	local i = 1
	local j = longitud

	-- for i=1, j=longitud; longitud/2,1 ; i++,j-- do

	-- if (string.sub(numeroString, i, i) ~= string.sub(numeroString, j, j))
	--		j = j-1
	-- end

	while i < j do
		if string.sub(numero_string, i, i) ~= string.sub(numero_string, j, j) then
			return false
		end

		i = i + 1
		j = j - 1

	end
	return true
end


local es_capicua = is_capicua("oruro")
print( "el numero " .. 1341 .. " es capicua: " , es_capicua )


local lista = {1,4,7,3,6,2,5,3,4}
lista2 = lista
table.sort( lista2  )



for i,v in ipairs(lista2) do
	print(i,v)
end

function esCapicua(numero)
  local cadena = tostring(numero)
  return cadena == string.reverse(cadena)
end
-- Prueba
local numero = 13421
if esCapicua(numero) then
  print(numero .. " es capicúa.")
else
  print(numero .. " no es capicúa.")
end
-- ejercio 1
function es_unico( lista, valor, indice )

	if valor == lista[indice] then

		return false
	elseif indice == #lista then
		return true
	else
		print("valor del indice", indice)
		return es_unico(lista, valor, indice+1)
	end
end


function unico2(lista, valor)
	local contador = 0
	for i=1, #lista do
		if lista[i] == valor then 
			contador = contador+1
		end
	end

	if contador == 1 then 
		return true
	else
		return false
	end

end
-- ejemplo ejercicio 1
print(es_unico( lista, 7, 1 ))
print(unico2(lista, 4))
