-- Primer Parcial - Introducción a la Programación, 2C 2024
-- Tema 2 - Turno mañana

-- Este es el parcial que me tocó en mi cursada. El único ejercicio que no pasó todos los
-- test es el 4 y me dio fiaca revisarlo, asi que dejo abajo los test que fallarron en la
-- corrección. Igualmente no garantizo que el resto de mi solución sea la más 
-- eficiente/elegante etc etc etc

-- Nota: 9.6 / 10.0 (APROBADO)
-- puntaje ej1: 2
-- puntaje ej2: 2
-- puntaje ej3: 2
-- puntaje ej4: 2.6
-- puntaje ej5: 1



---------------------------------------------------------------


-- EJERCICIO 1 (2 puntos)
-- problema mediaMovilN (lista: seq⟨Z⟩, n: Z) : Float {
--   requiere: {|lista| > 0}
--   requiere: {n > 0 ∧ n ≤ |lista|}
--   asegura: {res es el promedio de los últimos n elementos de lista}
-- }

mediaMovilN :: [Integer] -> Integer -> Float
mediaMovilN [] _ = 0
mediaMovilN (x:xs) n = division (sumatoria nElem) n
    where nElem = ultimosNElem (x:xs) n

-- AUX: deuvelve los ultimo n elementos de una lista
ultimosNElem :: [Integer] -> Integer -> [Integer]
ultimosNElem [] _ = []
ultimosNElem (x:xs) n
    | n >= largo = (x:xs)
    | otherwise = ultimosNElem xs n
    where largo = longitud (x:xs)

-- AUX: devuelve longitud de lista
longitud :: (Eq t) => [t] -> Integer
longitud [] = 0
longitud [x] = 1
longitud (x:xs) = 1 + longitud xs

-- AUX: devuelve la suma de todos los elementos de una lista
sumatoria :: [Integer] -> Integer
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

-- AUX: divison entre enteros que devuelve un float
division :: Integer -> Integer -> Float
division _ 0 = -999
division a b = fromInteger a / fromInteger b


---------------------------------------------------------------


-- EJERCICIO 2 (2 puntos)    n>0
-- problema esAtractivo (n: Z) : Bool {
--   requiere: {n > 0}
--   asegura: {res = true <=> la cantidad de factores primos de n (distintos o no) es también un número primo.}
-- }
-- Aclaración: los factores primos de 30 son [5,3,2]. Los factores primos de 9 son [3,3]. 

esAtractivo :: Integer -> Bool
esAtractivo n
    | n == 1 = False
    | otherwise = esPrimo cantFactores
    where cantFactores = longitud (factores n)

-- AUX: evalua si un entero positivo es primo
esPrimo :: Integer -> Bool
esPrimo n
    | n < 2 = False
    | otherwise = esPrimoAux n 2

esPrimoAux :: Integer -> Integer -> Bool
esPrimoAux n i -- invocar con i=2
    | n == i = True
    | mod n i == 0 = False
    | otherwise = esPrimoAux n (i+1)

-- AUX: devuelve el divisor primo mas grande de un entero
divPrimoMasGrande :: Integer -> Integer -> Integer
divPrimoMasGrande n i -- invocar con i=n
    | i == 2 = 2
    | mod n i == 0 && esPrimo i = i
    | otherwise = divPrimoMasGrande n (i-1)

-- AUX: devuelve la lista de factores primos de un entero
factores :: Integer -> [Integer]
factores n
    | esPrimo n = [n] --siempre va a llegar a algun primo eventualmente
    | otherwise = factorMayor : (factores (div n factorMayor)) --siempre sera valido pues n es divisible por factorMayor
    where factorMayor = divPrimoMasGrande n n


---------------------------------------------------------------


-- EJERCICIO 3 (2 puntos)
-- problema palabraOrdenada (palabra: seq⟨Char⟩) : Bool {
--   requiere: {True}
--   asegura: {res = true <=> cada uno de los elementos no blancos de palabra es mayor o igual al anterior caracter no blanco, si existe alguno.}
-- }
-- Aclaración: 'a' < 'b' es True. 

palabraOrdenada :: String -> Bool
palabraOrdenada [] = True
palabraOrdenada [x] = True
palabraOrdenada (x:y:xs) = palabraOrdenadaAux sinBlancos
    where sinBlancos = quitarBlancos (x:y:xs)

-- AUX: decide si una palabra sin blancos está ordenada de forma que cada uno de sus elementos son mayor o igual al anterior (x<=y)
palabraOrdenadaAux :: String -> Bool
palabraOrdenadaAux [] = True
palabraOrdenadaAux [x] = True
palabraOrdenadaAux (x:y:xs)
    | x <= y = palabraOrdenadaAux (y:xs)
    | otherwise = False

-- AUX: quita todos los caracteres blancos de una cadena
quitarBlancos :: [Char] -> [Char]
quitarBlancos [] = []
quitarBlancos (x:xs)
    | x == ' ' = quitarBlancos xs
    | otherwise = x : quitarBlancos xs


---------------------------------------------------------------


-- EJERCICIO 4 (3 puntos)
-- problema similAnagrama (palabra1: seq⟨Char⟩, palabra2: seq⟨Char⟩) : Bool⟩{
--   requiere: {True}
--   asegura: {res = true <=> (para todo caracter no blanco, la cantidad de apariciones de ese caracter en palabra1 es igual a la cantidad de apariciones en palabra2, y además existe al menos un caracter en palabra1 que tiene una posición distinta en palabra2)}
-- }

-- TESTS FALLIDOS:

-- ### Failure in: 0:similAnagrama Falso palabra1 contenida en palabra2
-- Tema2-test-ej4-test14.hs:16
-- expected: False
--  but got: True

-- ### Failure in: 0:similAnagrama True con espacios en diferente posicion
-- Tema2-test-ej4-test10.hs:16
-- expected: True
--  but got: False

similAnagrama :: String -> String -> Bool
similAnagrama p1 p2
    | p1 == [] || p2 == [] = False
    | p1SinBlancos == p2SinBlancos = False
    | otherwise = esPermutacion elemP1 p1SinBlancos p2SinBlancos
    where p1SinBlancos = quitarBlancos p1
          p2SinBlancos = quitarBlancos p2
          elemP1 = sinRep p1SinBlancos

-- AUX: cuenta la cantidad de apariciones de un elemento en una lista
cantApariciones :: (Eq t) => [t] -> t -> Integer
cantApariciones [] _ = 0
cantApariciones (x:xs) e
    | x == e = 1 + cantApariciones xs e
    | otherwise = cantApariciones xs e

-- AUX: devuelve la misma lista sin repetidos
sinRep :: (Eq t) => [t] -> [t]
sinRep [] = []
sinRep [x] = [x]
sinRep (x:y:xs)
    | pertenece (y:xs) x = sinRep (y:xs)
    | otherwise = x : (sinRep (y:xs))

-- AUX: evalua si un elemento pertenece a una lista
pertenece :: (Eq t) => [t] -> t -> Bool
pertenece [] _ = False
pertenece (x:xs) e
    | x == e = True
    | otherwise = pertenece xs e

-- AUX: evalua si una lista1 es permutacion de otra lista2 (donde (x:xs) es la lista de elementos unicos de l1)
esPermutacion :: (Eq t) => [t] -> [t] -> [t] -> Bool
esPermutacion [] _ _ = True
esPermutacion (x:xs) l1 l2
    | cantApariciones l1 x /= cantApariciones l2 x = False
    | otherwise = esPermutacion xs l1 l2


---------------------------------------------------------------


-- EJERCICIO 5 (1 punto)
-- ¿Cuándo se dice que una especificación está sub-especificada?:
-- [x] Cuando se da una precondición más restrictiva de lo realmente necesario, o bien una postcondición más débil de la que se necesita.
-- [ ] Cuando se da una precondición más débil de lo realmente necesario, o bien una postcondición más restrictiva de la que se necesita.
-- [ ] Cuando no hay precondiciones (o la precondición es True).