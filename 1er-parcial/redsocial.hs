-- SIMULACRO 20240925

module SolucionT1 where

{--
problema relacionesValidas (relaciones: seq⟨String x String⟩) : Bool {
  requiere: {True}
  asegura: {(res = true) <=> relaciones no contiene ni tuplas repetidas1, ni tuplas con ambas componentes iguales}
}
1 A los fines de este problema consideraremos que dos tuplas son iguales si el par de elementos que las componen (sin importar el orden) son iguales. 
--}

relacionesValidas :: [(String, String)] -> Bool
relacionesValidas [] = True
relacionesValidas (x:[]) = tuplaDesigual x
relacionesValidas (x:y:xs) = tuplaDesigual x && tuplaUnica && relacionesValidas (y:xs)
    where tuplaUnica = not (pertenece x (y:xs)) && not (pertenece (reversoTupla x) (y:xs))


-- AUX: evalua si los dos elementos de una tupla son distintos
tuplaDesigual :: (Eq t) => (t,t) -> Bool
tuplaDesigual (x,y) = x /= y

-- AUX: evalua si un elemento pertenece a una lista
pertenece :: (Eq t) => t -> [t] -> Bool
pertenece _ [] = False
pertenece e (x:[]) = e == x
pertenece e (x:y:xs)
    | e == x = True
    | otherwise = pertenece e (y:xs)

{--
parDeTuplasIguales :: (Eq t) => (t,t) -> (t,t) -> Bool
parDeTuplasIguales (a,b) (c,d) = (a,b) == (d,c)
--}

-- AUX: da vuelta una tupla
reversoTupla :: (Eq t) => (t,t) -> (t,t)
reversoTupla (x,y) = (y,x)

--------------------------------------------------------

{--
problema personas (relaciones: seq⟨String x String⟩) : seq⟨String⟩ {
  requiere: {relacionesValidas(relaciones)}
  asegura: {res no tiene elementos repetidos}
  asegura: {res tiene exactamente los elementos que figuran en alguna tupla de relaciones, en cualquiera de sus posiciones}
}
--}

personas :: [(String, String)] -> [String]
personas [] = []
personas (x:xs) = sacarRepetidos listaElem
    where listaElem = listarElemTuplas (x:xs)

-- AUX: toma una lista de tuplas y pone todos los elementos pertenecientes a las tuplas en una lista
listarElemTuplas :: (Eq t) => [(t,t)] -> [t]
listarElemTuplas [] = []
listarElemTuplas (x:[]) = fst x : [snd x]
listarElemTuplas (x:xs) = fst x : snd x : listarElemTuplas xs

-- AUX: saca elementos repetidos de una lista y deja una sola aparicion
sacarRepetidos :: (Eq t) => [t] -> [t]
sacarRepetidos [] = []
sacarRepetidos (x:xs)
    | pertenece x xs = sacarRepetidos xs
    | otherwise = x : sacarRepetidos xs

--------------------------------------------------------

{--
problema amigosDe (persona: String, relaciones: seq⟨String x String⟩) : seq⟨String⟩ {
  requiere: {relacionesValidas(relaciones)}
  asegura: {res tiene exactamente los elementos que figuran en las tuplas de relaciones en las que una de sus componentes es persona}
} 
--}

amigosDe :: String -> [(String, String)] -> [String]
amigosDe _ [] = []
amigosDe user (x:xs) = quitarElem user listaAmigos
    where listaAmigos = personas (relacionesDeUser user (x:xs))

-- AUX: filtra una lista de relaciones para solo mostrar las tuplas donde aparece el user
relacionesDeUser :: (Eq t) => t -> [(t,t)] -> [(t,t)]
relacionesDeUser _ [] = []
relacionesDeUser user(x:xs)
    | estaEnTupla user x = x : (relacionesDeUser user xs)
    | otherwise = relacionesDeUser user xs

-- AUX: evalua si un elemento esta en una tupla
estaEnTupla :: (Eq t) => t -> (t,t) -> Bool
estaEnTupla e (x,y) = e == x || e == y

-- AUX: quita un elemento de una lista
quitarElem :: (Eq t) => t -> [t] -> [t]
quitarElem _ [] = []
quitarElem e (x:xs)
    | e == x = quitarElem e xs
    | otherwise = x : quitarElem e xs

--------------------------------------------------------

{--
problema personaConMasAmigos (relaciones: seq⟨String x String⟩) : String {
  requiere: {relaciones no vacía}
  requiere: {relacionesValidas(relaciones)}
  asegura: {res es el Strings que aparece más veces en las tuplas de relaciones (o alguno de ellos si hay empate)}
}
--}

personaConMasAmigos :: [(String, String)] -> String
personaConMasAmigos [] = "n/a"
personaConMasAmigos (x:[]) = fst x -- tanto fst x como snd x van a tener la misma cantidad de amigos (1), asi que elijo cualquiera
personaConMasAmigos (x:y:xs) = userMasAmiguero (personas (x:y:xs)) (x:y:xs)

-- longitud de una lista
longitud :: (Eq t) => [t] -> Integer
longitud [] = 0
longitud (x:[]) = 1
longitud (x:y:xs) = 1 + longitud (y:xs)

-- cantidad de elementos con los que tiene relacion cierto usuario
cantAmigos :: String -> [(String,String)] -> Integer
cantAmigos user relaciones = longitud (amigosDe user relaciones)

-- usuarios -> relaciones -> el + amiguero
userMasAmiguero :: [String] -> [(String,String)] -> String
userMasAmiguero [] _ = "n/a"
userMasAmiguero _ [] = "n/a"
userMasAmiguero (x:[]) rel = x
userMasAmiguero (x:y:xs) rel
    | cantAmigos x rel >= cantAmigos y rel = userMasAmiguero (x:xs) rel
    | otherwise = userMasAmiguero (y:xs) rel