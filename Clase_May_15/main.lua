
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

