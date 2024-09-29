module Democracia where

{--
======================================
VIVA LA DEMOCRACIA
======================================

La elección periódica de los gobernantes es la base de los Estados Modernos. Este sistema, 
denominado "democracia" (término proveniente de la antigua Grecia), tiene diferentes variaciones, 
que incluyen diferentes formas de elección del/a máximo/a mandatario/a. Por ejemplo, en algunos 
países se eligen representantes en un colegio electoral (EEUU). En otros se vota a los/as miembros 
del parlamento (España). En nuestro país elegimos de forma directa la fórmula presidencial 
(Presidente/a y Vicepresidente/a) cada 4 años.

A continuación presentamos una serie de ejercicios que tienen como objetivo implementar funciones 
para sistema de escrutinio de una elección presidencial. Leer las descripciones y especificaciones 
e implementar las funciones requeridas en Haskell, utilizado sóĺamente las herramientas vistas en 
clase.

Las fórmulas presidenciales serán representadas por tuplas (String x String), donde la primera 
componente será el nombre del candidato a presidente, y la segunda componente será el nombre del 
candidato a vicepresidente.

En los problemas en los cuales se reciban como parámetro secuencias de fórmulas y votos, cada 
posición de la lista votos representará la cantidad de votos obtenidos por la fórmula del parámetro 
formulas en esa misma posición. Por ejemplo, si la lista de fórmulas es [("Juan Pérez","Susana 
García"), ("María Montero","Pablo Moreno")] y la lista de votos fuera [34, 56], eso indicaría que 
la fórmula encabezada por María Montero obtuvo 56 votos, y la lista encabezada por Juan Pérez 
obtuvo 34 votos.
--}


-- Ejercicio 1
{--
problema porcentajeDeVotosAfirmativos (formulas: seq⟨String x String⟩,votos:seq< Z >, cantTotalVotos: Z) : R {
 requiere: {¬formulasInvalidas(formulas)}
 requiere: {|formulas| = |votos|}
 requiere: {Todos los elementos de votos son mayores o iguales a 0}
 requiere: {La suma de todos los elementos de votos es menor o igual a cantTotalVotos}
 asegura: {res es el porcentaje de votos no blancos (es decir, asociados a alguna de las fórmulas) sobre el total de votos emitidos}
}
--}
porcentajeDeVotosAfirmativos :: [(String, String)] -> [Int] -> Int  -> Float
porcentajeDeVotosAfirmativos _ _ _ = 0

-- AUX: devuelve como float la division de dos enteros
division :: Int -> Int -> Float
division a b = (fromIntegral a) / (fromIntegral b)


-- Ejercicio 2
formulasInvalidas :: [(String, String)] -> Bool
formulasInvalidas _ = True


-- Ejercicio 3
porcentajeDeVotos :: String -> [(String, String)] -> [Int] -> Float
porcentajeDeVotos _ _ _ = 0.0


-- Ejercicio 4
menosVotado :: [(String, String)] -> [Int] -> String
menosVotado _ _ = ""