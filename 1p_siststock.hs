{--
======================================
SISTEMA DE STOCK
======================================

"Una reconocida empresa de comercio electronico nos pide desarrollar un sistema de stock de mercaderia. El conjunto de
mercaderias puede representarse con una secuencia de nombres de los productos, donde puede haber productos repetidos. El
stock puede representarse como una secuencia de tuplas de dos elementos, donde el primero es el nombre del producto y el
segundo es la cantidad que hay en stock (en este caso no hay nombre de productos repetidos). También se cuenta con una
lista de precios de productos representada como una secuencia de tuplas de dos elementos, donde el primero es el nombre
del producto y el segundo es el precio.
Para implementar este sistema nos enviaron las siguientes especificaciones y nos pidieron que hagamos el desarrollo
enteramente en Haskell, utilizando los tipos requeridos y solamente las funciones que se ven en la materia Introduccion a la
Programacion / Algoritmos y Estructuras de Datos I (FCEyN-UBA)."

* La mercadería puede tener productos repetidos
* En stock no hay nombres de productos repetidos
--}

-- EJERCICIO 1
{--
problema generarStock (productos: seq⟨String⟩) : seq⟨String × Z⟩ {
    requiere: {True}
    asegura: { La longitud de res es igual a la cantidad de productos distintos que hay en productos}
    asegura: {Para cada producto que pertenece a productos existe un i tal que 0 ≤ i < |res| y res[i]0=producto y
    res[i]1 es igual a la cantidad de veces que aparece producto en productos}
}
--}

-- tests: lista vacia, 1 elemento, todos elementos repetidos, todos elementos distintos, varios con repeticiones ordenadas, varios con repeticiones mezcladas
generarStock :: [String] ->[(String, Int)]
generarStock [] = []
generarStock (x:[]) = [(x, 1)]
generarStock (x:xs) = stockX : (generarStock tailSinX)
    where stockX = (x, (contarApariciones x (x:xs)))
          tailSinX = sacarElementos x xs

-- AUX: cuenta todas las apariciones de un elemento en una lista
contarApariciones :: (Eq t) => t -> [t] -> Int
contarApariciones _ [] = 0
contarApariciones elem (x:xs)
    | elem == x = 1 + (contarApariciones elem xs)
    | otherwise = contarApariciones elem xs

-- AUX: saca todas las apariciones en una lista de un elemento
sacarElementos :: (Eq t) => t -> [t] -> [t]
sacarElementos _ [] = []
sacarElementos elem (x:xs)
    | elem == x = sacarElementos elem xs
    | otherwise = x : (sacarElementos elem xs)

---------------------------------------------------------

-- EJERCICIO 2

{--
problema stockDeProducto (stock: seq⟨String × Z⟩, producto: String ) : Z {
    requiere: {No hay productos repetidos en stock}
    requiere: {Todas las cantidades (segundas componentes) de stock son mayores a cero}
    asegura: {(res = 0 y producto no se encuentra en el stock) o (existe un i tal que 0 ≤ i < |stock| y producto = stock[i]0
    y res = stock[i]1}
}
--}

-- stock de prueba: [("a", 8), ("b", 18), ("c", 1), ("d", 2)]

stockDeProducto :: [(String, Int)] -> String -> Int
stockDeProducto [] _ = 0
stockDeProducto ((nom, stock):[]) prod
    | prod == nom = stock
    | otherwise = 0
stockDeProducto ((nom, stock):y:xs) prod
    | prod == nom = stock
    | otherwise = stockDeProducto (y:xs) prod

---------------------------------------------------------

-- EJERCICIO 3

{--
problema dineroEnStock (stock: seq⟨String × Z⟩, precios: seq⟨String × R⟩ ) : R {
    requiere: {No hay productos repetidos en stock}
    requiere: {No hay productos repetidos en precios}
    requiere: {Todas las cantidades (segundas componentes) de stock son mayores a cero}
    requiere: {Todas las precios (segundas componentes) de precios son mayores a cero}
    requiere: {Todo producto de stock aparece en la lista de precios}
    asegura: {res es igual a la suma de los precios de todos los productos que est´an en stock multiplicado por la cantidad
    de cada producto que hay en stock}
}
--}

-- precios de prueba: [("a",100),("b",150),("c",10),("d",500)]

dineroEnStock :: [(String, Int)] -> [(String, Float)] -> Float
dineroEnStock [] _ = 0
dineroEnStock _ [] = 0
dineroEnStock (s:sz) (p:ps) = stockS * precioS + dineroEnStock sz (p:ps)
    where stockS = fromIntegral (snd s)
          precioS = precioDeProducto (fst s) (p:ps)

-- AUX: busca en una lista de tuplas (nombre, precio) el precio de un cierto producto
precioDeProducto :: String -> [(String, Float)] -> Float
precioDeProducto _ [] = -1
precioDeProducto prod (x:xs)
    | prod == fst x = snd x
    | otherwise = precioDeProducto prod xs

---------------------------------------------------------

-- EJERCICIO 4

{--
problema aplicarOferta (stock: seq⟨String × Z⟩, precios: seq⟨String × R⟩ ) : seq⟨String × R⟩ {
    requiere: {No hay productos repetidos en stock}
    requiere: {No hay productos repetidos en precios}
    requiere: {Todas las cantidades (segundas componentes) de stock son mayores a cero}
    requiere: {Todas las precios (segundas componentes) de precios son mayores a cero}
    requiere: {Todo producto de stock aparece en la lista de precios}
    asegura: {|res| = |precios|}
    asegura: {Para todo 0 ≤ i < |precios|, si stockDeProducto(stock, precios[i]0) > 10, entonces res[i]0 = precios[i]0 y
    res[i]1 = precios[i]1∗ 0,80}
    asegura: {Para todo 0 ≤ i < |precios|, si stockDeProducto(stock, precios[i]0) ≤ 10, entonces res[i]0 = precios[i]0 y
    res[i]1 = precios[i]1 }
}
--}

aplicarOferta :: [(String, Int)] -> [(String, Float)] -> [(String, Float)]
aplicarOferta _ [] = []
aplicarOferta stock (p:ps)
    | stockDeProducto stock prod > 10 = (prod, enOferta) : (aplicarOferta stock ps)
    | otherwise = p : (aplicarOferta stock ps)
    where prod = fst p
          enOferta = (snd p) * 0.80