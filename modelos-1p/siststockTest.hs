import SistStock
import Test.HUnit

-- EJERCICIO 1
testGenerarStock = test [
    "lista vacia" ~: (generarStock []) ~?= [],
    "1 solo elemento" ~: (generarStock ["a"]) ~?= [("a",1)],
    "todos elementos repetidos" ~: (generarStock ["a","a","a"]) ~?= [("a",3)],
    "todos elementos distintos" ~: (generarStock ["a","b","c"]) ~?= [("a",1),("b",1),("c",1)],
    "varios con repeticiones ordenadas" ~: (generarStock ["a","b","b","c"]) ~?= [("a",1),("b",2),("c",1)],
    "varios con repeticiones mezcladas" ~: (generarStock ["a","b","a","a","c","a","d","c"]) ~?= [("a",4),("b",1),("c",2),("d",1)]
    ]

runEj1 = runTestTT testGenerarStock



-- -- FUNCIONES PARA TESTING, NO BORRAR
-- -- expectAny permite saber si el elemenot que devuelve la función es alguno de los esperados
expectAny actual expected = elem actual expected ~? ("expected any of: " ++ show expected ++ "\n but got: " ++ show actual)


quitar :: (Eq t) => t -> [t] -> [t]
-- -- requiere x pertenece a y
quitar x (y:ys)
  | x == y = ys
  | otherwise = y : quitar x ys

incluido :: (Eq t) => [t] -> [t] -> Bool
incluido [] l = True
incluido (x:c) l = elem x l && incluido c (quitar x l)

-- -- sonIguales permite ver que dos listas sean iguales si no importa el orden
sonIguales :: (Eq t) => [t] -> [t] -> Bool
sonIguales xs ys = incluido xs ys && incluido ys xs