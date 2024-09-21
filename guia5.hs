{-# OPTIONS_GHC -Wno-x-partial #-} --ocultar advertencia de que head y tail (usadas en ej 2.8) son funciones parciales (cubrí con guardas los casos en los que podrían fallar)
-- 20240918: 2.5, 1.1, 1.2, 3.3, 3.9, 1.3, 1.4, 2.1, 2.2

-- EJERCICIO 1.1
longitud :: [t] -> Integer
longitud [] = 0
longitud (x:xs) = 1 + longitud xs

-- EJERCICIO 1.2
-- precond: (x:xs) tiene al menos 1 elemento
ultimo :: [t] -> t
ultimo (x:xs)
    | longitud xs == 0 = x
    | otherwise = ultimo xs

-- EJERCICIO 1.3
-- precond: (x:xs) tiene al menos 1 elemento
principio :: (Eq t) => [t] -> [t]
principio (x:[]) = []
principio (x:y:xs) = quitar (ultimo (x:y:xs)) (x:y:xs)

-- EJERCICIO 1.4
reverso :: [t] -> [t]
reverso [] = []
reverso (x:[]) = [x]
reverso (x:y:xs) = reverso (y:xs) ++ [x]

-- EJERCICIO 2.1
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece e [] = False
pertenece e (x:[]) = e == x
pertenece e (x:y:xs) = (e == x)||(pertenece e (y:xs))

-- EJERCICIO 2.2
todosIguales :: (Eq t) => [t] -> Bool
todosIguales [] = False
todosIguales (x:[]) = True
todosIguales (x:y:xs) = (x == y)&&(todosIguales (y:xs))

-- EJERCICIO 2.3
todosDistintos :: (Eq t) => [t] -> Bool
todosDistintos [] = False
todosDistintos (x:[]) = True -- caso base
todosDistintos (x:y:xs)
    | pertenece x (y:xs) = False -- ¿está el primer elemento en el resto de la lista?
    | otherwise = todosDistintos (y:xs) -- descarto el primero y chequeo si el siguiente elemento está en el resto

-- EJERCICIO 2.4
hayRepetidos :: (Eq t) => [t] -> Bool
hayRepetidos [] = False
hayRepetidos lista = not (todosDistintos lista) -- todosDistintos revisa lo que necesito (repeticiones de elementos), pero me da el resultado contrario

-- EJERCICIO 2.5
quitar :: (Eq t) => t -> [t] -> [t]
quitar _ [] = []
quitar elem (x:xs)
    | elem == x = xs
    | otherwise = x:(quitar elem xs)

-- EJERCICIO 2.6
quitarTodos :: (Eq t ) => t -> [t] -> [t]
quitarTodos _ [] = []
quitarTodos e (x:[])
    | e == x = []
    | otherwise = (x:[])
quitarTodos e (x:y:xs)
    | e == x = quitarTodos e (y:xs)
    | otherwise = x:(quitarTodos e (y:xs))

-- EJERCICIO 2.7
eliminarRepetidos :: (Eq t) => [t] -> [t]
eliminarRepetidos [] = []
eliminarRepetidos (x:[]) = [x]
eliminarRepetidos (x:y:xs) = x : (eliminarRepetidos tailSinX)
    where tailSinX = quitarTodos x (y:xs)

-- EJERCICIO 2.8
mismosElementos :: (Eq t) => [t] -> [t] -> Bool
mismosElementos [] [] = True
mismosElementos (x:[]) (y:[]) = x == y
mismosElementos (x:y:xs) (v:w:vs) = (listaContenida (x:y:xs) (v:w:vs))&&(listaContenida (v:w:vs) (x:y:xs))

listaContenida :: (Eq t) => [t] -> [t] -> Bool -- chequea si los elementos de una lista están contenidos en otra (sin repeticiones)
listaContenida lista1 lista2
    | lista1 == [] && lista2 == [] = True
    | lista1 == [] || lista2 == [] = False -- lista2 es vacía pero lista1 tiene al menos 1 elemento (no se cumple que esté contenida)
    | longitud sinRepL1 == 1 = pertenece (head sinRepL1) sinRepL2 --caso base
    | otherwise = (pertenece (head sinRepL1) sinRepL2)&&(listaContenida (tail sinRepL1) sinRepL2)
        where sinRepL1 = eliminarRepetidos lista1
              sinRepL2 = eliminarRepetidos lista2

-- EJERCICIO 2.9
capicua :: (Eq t) => [t] -> Bool
capicua [] = True
capicua (x:[]) = True
capicua (x:y:xs) = (x:y:xs) == reverso (x:y:xs)

-- EJERCICIO 3.1
sumatoria :: [Integer] -> Integer
sumatoria [] = 0
sumatoria (x:[]) = x
sumatoria (x:y:xs) = x + sumatoria (y:xs)

-- EJERCICIO 3.2
productoria :: [Integer] -> Integer
productoria [] = 0
productoria (x:[]) = x
productoria (x:y:xs) = x * productoria (y:xs)

-- EJERCICIO 3.3
-- precond: (x:xs) tiene al menos 1 elemento
maximo :: [Integer] -> Integer
maximo (x:[]) = x -- caso para lista de 1 elem.
maximo (x:y:xs) -- esto es equiv. a [x,y]++xs donde xs es una lista que puede ser vacia => este es el caso con minimo 2 elem.
    | x > y = maximo (x:xs)
    | otherwise = maximo (y:xs)

mayorEnPar :: Integer -> Integer -> Integer
mayorEnPar n m
    | n >= m = n
    | otherwise = m

-- EJERCICIO 3.4
sumarN :: Integer -> [Integer] -> [Integer]
sumarN n [] = [n]
sumarN 0 lista = lista
sumarN n (x:[]) = [x+n]
sumarN n (x:y:xs) = (x+n):(sumarN n (y:xs))

-- EJERCICIO 3.5
sumarElPrimero :: [Integer] -> [Integer]
sumarElPrimero [] = []
sumarElPrimero (x:[]) = [x+x]
sumarElPrimero (x:y:xs) = sumarN x (x:y:xs)

-- EJERCICIO 3.9
ordenar :: [Integer] -> [Integer]
ordenar [] = []
ordenar (x:[]) = x:[]
ordenar (x:y:xs) = ordenar (quitar max lista)++[max]
    where lista = (x:y:xs)
          max = maximo lista

-- EJERCICIO 6
{--
type Texto = [Char]
type Nombre = Texto
type Telefono = Texto
type Contacto = (Nombre, Telefono)
type ContactosTel = [Contacto]
--}