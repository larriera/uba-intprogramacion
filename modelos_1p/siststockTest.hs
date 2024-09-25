import SistStock
import Test.HUnit

-- EJERCICIO 1
testGenerarStock = test [
    "lista vacia" ~: (generarStock []) ~?= [],
    "1 solo elemento" ~: (generarStock ["a"]) ~?= [("a",1)],
    "todos elementos repetidos" ~: (generarStock ["a","a","a"]) ~?= [("a",1)],
    "todos elementos distintos" ~: (generarStock ["a","b","c"]) ~?= [("a",1),("b",1),("c",1)],
    "varios con repeticiones ordenadas" ~: (generarStock ["a","b","b","c"]) ~?= [("a",1),("b",2),("c",1)],
    "varios con repeticiones mezcladas" ~: (generarStock ["a","b","a","a","c","a","d","c"]) ~?= [("a",4),("b",1),("c",2),("d",1)],
]