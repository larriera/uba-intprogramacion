{-# OPTIONS_GHC -Wno-x-partial #-} --ocultar advertencia de que head y tail (usadas en ej 2.8) son funciones parciales (cubrí con guardas los casos en los que podrían fallar)
-- 20240918: 2.5, 1.1, 1.2, 3.3, 3.9, 1.3, 1.4, 2.1, 2.2

type Texto = [Char]
type Nombre = Texto
type Telefono = Texto
type Contacto = (Nombre, Telefono)
type ContactosTel = [Contacto]

type Identificacion = Integer
type Ubicacion = Texto
type Estado = (Disponibilidad, Ubicacion)
type Locker = (Identificacion, Estado)
type MapaDeLockers = [Locker]
type Disponibilidad = Bool

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
sumatoria :: (Num t) => [t] -> t
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

-- EJERCICIO 3.6
sumarElUltimo :: [Integer] -> [Integer]
sumarElUltimo [] = []
sumarElUltimo (x:[]) = [x+x]
sumarElUltimo (x:y:xs) = sumarN (ultimo (x:y:xs)) (x:y:xs)

-- EJERCICIO 3.7
pares :: [Integer] -> [Integer]
pares [] = []
pares (x:[])
    | mod x 2 == 0 = [x]
    | otherwise = []
pares (x:y:xs)
    | mod x 2 == 0 = x:(pares (y:xs))
    | otherwise = pares (y:xs)

-- EJERCICIO 3.8
multiplosDeN :: Integer -> [Integer] -> [Integer]
multiplosDeN _ [] = []
multiplosDeN n (x:[])
    | mod x n == 0 = [x]
    | otherwise = []
multiplosDeN n (x:y:xs)
    | mod x n == 0 = x:(multiplosDeN n (y:xs))
    | otherwise = multiplosDeN n (y:xs)

-- EJERCICIO 3.9
ordenar :: [Integer] -> [Integer]
ordenar [] = []
ordenar (x:[]) = x:[]
ordenar (x:y:xs) = ordenar (quitar max lista)++[max]
    where lista = (x:y:xs)
          max = maximo lista

-- EJERCICIO 4a
sacarBlancosRepetidos :: Texto -> Texto
sacarBlancosRepetidos [] = []
sacarBlancosRepetidos (x:[]) = [x]
sacarBlancosRepetidos (x:y:xs)
    | x == blanco && y == blanco = sacarBlancosRepetidos (y:xs)
    | otherwise = x:(sacarBlancosRepetidos (y:xs))
        where blanco = ' ' -- observación: ' ' :: Char / " " :: String = [Char]   (https://stackoverflow.com/a/14948777)

-- EJERCICIO 4b
contarPalabras :: Texto -> Integer
contarPalabras [] = 0
contarPalabras (x:[])
    | x == ' ' = 0
    | otherwise = 1
contarPalabras (x:y:xs)
    | head txtNormal == ' ' = espacios - 1
    | otherwise = espacios
        where txtNormal = sacarBlancosRepetidos ((x:y:xs)++ " ") -- agrego un espacio para que no se rompa en el caso head txtNormal == ' '
              espacios = (contarApariciones ' ' txtNormal)

contarApariciones :: (Eq t) => t -> [t] -> Integer
contarApariciones _ [] = 0
contarApariciones elem (x:[])
    | x == elem = 1
    | otherwise = 0
contarApariciones elem (x:y:xs)
    | x == elem = 1 + contarApariciones elem (y:xs)
    | otherwise = contarApariciones elem (y:xs)

-- EJERCICIO 4c
palabras :: Texto -> [Texto]
palabras [] = []
palabras (x:[])
    | x /= ' ' = [[x]]
    | otherwise = []
palabras (x:y:xs)
    | x /= ' ' = (hastaPrimerSep ' ' (x:y:xs)):[] ++ palabras (empezarEnSep ' ' (y:xs))
    | otherwise = palabras (y:xs)

hastaPrimerSep :: (Eq t) => t -> [t] ->  [t]
hastaPrimerSep _ [] = []
hastaPrimerSep sep (x:xs)
    | x == sep = []
    | otherwise = x : hastaPrimerSep sep xs

empezarEnSep :: (Eq t) => t -> [t] -> [t]
empezarEnSep _ [] = []
empezarEnSep sep (x:xs)
    | x == sep = xs
    | otherwise = empezarEnSep sep xs

-- EJERCICIO 4d
-- aclaración: si existe más de una ocurrencia de palabra de longitud más larga, se devolverá la primera ocurrencia
-- por ejemplo: palabraMasLarga "aaa bbb" devuelve "aaa"
palabraMasLarga :: Texto -> Texto
palabraMasLarga [] = []
palabraMasLarga (x:xs) = listaMaxima (palabras (x:xs))

listaMayor :: (Eq t) => [t] -> [t] -> [t]
listaMayor lista1 lista2
    | longitud lista1 >= longitud lista2 = lista1
    | otherwise = lista2
        
listaMaxima :: (Eq t) => [[t]] -> [t]
listaMaxima [] = []
listaMaxima (x:[]) = x
listaMaxima (x:y:xs)
    | listaMayor x y == x = listaMaxima (x:xs)
    | otherwise = listaMaxima (y:xs)

-- EJERCICIO 4e
aplanar :: [Texto] -> Texto
aplanar [] = []
aplanar (x:xs) = x ++ aplanar xs

-- EJERCICIO 4f
aplanarConBlancos :: [Texto] -> Texto
aplanarConBlancos [] = []
aplanarConBlancos (x:[]) = x
aplanarConBlancos (x:xs) = x ++ " " ++ aplanarConBlancos xs

-- EJERCICIO 4g
aplanarConNBlancos :: [Texto] -> Integer -> Texto
aplanarConNBlancos _ 0 = []
aplanarConNBlancos (x:[]) _ = x
aplanarConNBlancos (x:xs) n = x ++ (textoNveces n " ") ++ aplanarConNBlancos xs n

-- precond: n>0
textoNveces :: Integer -> Texto -> Texto
textoNveces 1 txt = txt
textoNveces n txt = txt ++ textoNveces (n-1) txt

-- EJERCICIO 5.1
-- precond: todos los elementos de [t] son >0
sumaAcumulada :: (Num t) => [t] -> [t]
sumaAcumulada [] = []
sumaAcumulada (x:[]) = [x]
sumaAcumulada (x:y:xs) = reverso (sumaAcumuladaReves reves) -- conseguimos sumaAcumulada yendo de derecha a izquierda, y damos vuelta el orden del resultado para cumplir lo pedido
    where reves = reverso (x:y:xs)

-- sumaAcumulada, pero yendo de derecha a izquierda
sumaAcumuladaReves :: (Num t) => [t] -> [t]
sumaAcumuladaReves [] = []
sumaAcumuladaReves (x:[]) = [x]
sumaAcumuladaReves (x:y:xs) = sumatoria (x:y:xs) : (sumaAcumuladaReves (y:xs))

-- EJERCICIO 6
elNombre :: Contacto -> Nombre
elNombre (nom, tel) = nom

elTelefono :: Contacto -> Nombre
elTelefono (nom, tel) = tel

-- EJERCICIO 6a
enLosContactos :: Nombre -> ContactosTel -> Bool
enLosContactos _ [] = False
enLosContactos nom (x:[]) = nom == elNombre x
enLosContactos nom (x:y:xs)
    | nom == elNombre x = True
    | otherwise = enLosContactos nom (y:xs)

-- EJERCICIO 6b
agregarContacto :: Contacto -> ContactosTel -> ContactosTel
agregarContacto c [] = [c]
agregarContacto c (x:[])
    | elNombre c == elNombre x = [c]
    | otherwise = x : [c]
agregarContacto c (x:y:xs)
    | elNombre c == elNombre x = (c:y:xs)
    | otherwise = x : (agregarContacto c (y:xs))

-- EJERCICIO 6c
-- asumo que los nombres de contacto son únicos y tienen a lo sumo 1 sola aparicion en la lista de contactos
eliminarContacto :: Nombre -> ContactosTel -> ContactosTel
eliminarContacto _ [] = []
eliminarContacto nom (x:[])
    | nom == elNombre x = []
    | otherwise = [x]
eliminarContacto nom (x:xs)
    | nom == elNombre x = xs
    | otherwise = x : (eliminarContacto nom xs)

-- EJERCICIO 7.1
existeElLocker :: Identificacion -> MapaDeLockers -> Bool
existeElLocker _ [] = False
existeElLocker id (x:[]) = id == (idLocker x)
existeElLocker id (x:y:xs)
    | id == (idLocker x) = True
    | otherwise = existeElLocker id (y:xs)

idLocker :: Locker -> Identificacion
idLocker (id, _) = id

-- EJERCICIO 7.2
ubicacionDelLocker :: Identificacion -> MapaDeLockers -> Ubicacion
ubicacionDelLocker _ [] = "Locker no existe"
ubicacionDelLocker id (x:[])
    | id == idLocker x = ubicacionLocker x
    | otherwise = "Locker no existe"
ubicacionDelLocker id (x:y:xs)
    | id == idLocker x = ubicacionLocker x
    | otherwise = ubicacionDelLocker id (y:xs)

laUbicacion :: Estado -> Ubicacion
laUbicacion (_, ubi) = ubi

ubicacionLocker :: Locker -> Ubicacion
ubicacionLocker (_, est) = laUbicacion est

-- EJERCICIO 7.3
estaDisponibleElLocker :: Identificacion -> MapaDeLockers -> Bool
estaDisponibleElLocker _ [] = False
estaDisponibleElLocker id (x:[])
    | id == idLocker x = lockerDisponible x
    | otherwise = False
estaDisponibleElLocker id (x:y:xs)
    | id == idLocker x = lockerDisponible x
    | otherwise = estaDisponibleElLocker id (y:xs)

disponible :: Estado -> Disponibilidad
disponible (disp, _) = disp

lockerDisponible :: Locker -> Disponibilidad
lockerDisponible (_, est) = disponible est

-- EJERCICIO 7.4
ocuparLocker :: Identificacion -> MapaDeLockers -> MapaDeLockers
ocuparLocker _ [] = []
ocuparLocker id (x:[])
    | id == idLocker x = []
    | otherwise = [x]
ocuparLocker id (x:y:xs)
    | id == idLocker x = ((lockerOcupado x):y:xs)
    | otherwise = x : (ocuparLocker id (y:xs))

lockerOcupado :: Locker -> Locker
lockerOcupado (id, est)
    | lockerDisponible (id, est) = (id, cambiarDisp est)
    | otherwise = (id, est)

cambiarDisp :: Estado -> Estado
cambiarDisp (disp, ubi) = (not disp, ubi)