-- 20240902: 1a, 1b, 1c, 2a, 2b, 2c, 2d, 2g, 2i, 4b
-- 20240904: 4c, 4f, 6, 7, 2j, 8, 2e, 4i
-- casa: 2h, 4e (falta optimizar) 4g, 4h

-- REVISAR: 4e!!, 2e, 3, 5 (no entendi el proposito de la funcion)





-- ctrl+p ext install haskell.haskell / ext install justusadam.language-haskell

type Punto2D = (Float, Float)
type Punto3D = (Float, Float, Float)

-- Primera función de prueba:
doubleMe :: Integer -> Integer
doubleMe x = x + x

-- $ pwd : muestra dir en el que estoy
-- $ ls : muestra carpetas dentro de dir actual
-- $ cd : cambia dir actual
-- $ ghci : ejecuta ghci (para ejecutar haskell)
-- $ :l miArchivo.hs : carga archivo
-- $ :r : reloadea archivo (usar luego de cambios)

{-
comentario multilínea
-}

-- EJERCICIO 1a
-- Precondición: n pertenece a {1, 4, 16}
f :: Integer -> Integer
f n
    | n == 1 = 8
    | n == 4 = 131
    | n == 16 = 16

-- Otra opción con pattern matching:
fAlt :: Integer -> Integer
fAlt 1 = 8
fAlt 4 = 131
fAlt 16 = 16

-- EJERCICIO 1b
-- Precondición: n pertenece a {8, 16, 131}
g :: Integer -> Integer
g n 
    | n == 8 = 16
    | n == 16 = 4
    | n == 131 = 1

-- EJERCICIO 1c
-- Observación: la función sólo está definida en el dominio de g
h :: Integer -> Integer
h n = f(g n)

-- Observación: la función sólo está definida en el dominio de f
k :: Integer -> Integer
k n = g(f n)

-- EJERCICIO 2a
-- Observación (sobre Haskell): para llamar la función con un número negativo, escribirlo como (-x)
absoluto :: Integer -> Integer
absoluto x 
    | x < 0 = -x
    | otherwise = x

-- EJERCICIO 2b
{-
Sean x, y enteros. Sea abs(k) = |k|
f(x, y) | si abs(x) >= abs(y) -> abs(x)
        | otherwise -> abs(y)
-}
maximoabsoluto :: Integer -> Integer -> Integer
maximoabsoluto x y 
    | absoluto x >= absoluto y = absoluto x
    | otherwise = absoluto y

-- EJERCICIO 2c
-- Observación: recordar que Haskell va descartando condiciones de arrriba a abajo
maximo3 :: Integer -> Integer -> Integer -> Integer
maximo3 x y z 
    | (x >= y)&&(x >= z) = x
    | y >= z = y
    | otherwise = z

-- EJERCICIO 2d
algunoEs0 :: Float -> Float -> Bool
algunoEs0 x y = (x == 0)||(y == 0)

-- Versión con pattern matching:
algunoEs0Alt :: Float -> Float -> Bool
algunoEs0Alt _ 0 = True
algunoEs0Alt 0 _ = True
algunoEs0Alt _ _ = False

-- EJERCICIO 2e
ambosSon0 :: Float -> Float -> Bool
ambosSon0 x y = (x == 0)&&(y == 0)

-- Versión con pattern matching:
ambosSon0Alt :: Float -> Float -> Bool
ambosSon0Alt 0 0 = True
ambosSon0Alt _ _ = False

-- EJERCICIO 2f
mismoIntervalo :: Float -> Float -> Bool
mismoIntervalo x y = ((x <= 3)&&(y <= 3))||((x > 7)&&(y > 7))||(((x > 3)&&(x <= 7))&&((y > 3)&&(y <= 7)))

-- EJERCICIO 2g
sumaDistintos :: Integer -> Integer -> Integer -> Integer
sumaDistintos x y z 
    | (x == y)&&(y == z) = x --cuando son todos iguales
    | x == z = x+y
    | x == y = x+z
    | y == z = x+y
    | otherwise = x+y+z

-- EJERCICIO 2h
esMultiploDe :: Integer -> Integer -> Bool
esMultiploDe x y = (mod x y) == 0

-- EJERCICIO 2i
-- mod x y: te da el resto de dividir x/y
digitoUnidades :: Integer -> Integer
digitoUnidades x = mod (abs x) 10

-- EJERCICIO 2j
-- precond: x > 9
digitoDecenas :: Integer -> Integer
digitoDecenas x = div ((mod (abs x) 100) - (digitoUnidades x)) 10

-- EJERCICIO 3
-- precondición: a/=0, b/=0
estanRelacionados :: Integer -> Integer -> Bool
estanRelacionados a b = (mod a b) == 0

{-
a*a + a*b*k = 0
a*a = -(a*b*k)
a*a = a*b*k*(-1)
a = b*k*(-1)
a/b = k*(-1) con K entero -> a tiene que ser divisible por b -> el resto de a/b es 0
-}

-- EJERCICIO 4a
prodInt :: Punto2D -> Punto2D -> Float
prodInt (a,b) (c,d) = a*b + c*d

-- EJERCICIO 4b
todoMenor :: Punto2D -> Punto2D -> Bool
todoMenor x y | (fst x < fst y)&&(snd x < snd y) = True
              | otherwise = False

-- Otra forma mejor:
todoMenorAlt :: Punto2D -> Punto2D -> Bool
todoMenorAlt (a,b) (c,d) = a < c && b < d

-- EJERCICIO 4c
distanciaPuntos :: Punto2D -> Punto2D -> Float
distanciaPuntos (a,b) (c,d) = sqrt ((c-a)**2 + (d-b)**2)

-- EJERCICIO 4d
sumaTerna :: Punto3D -> Float
sumaTerna (a,b,c) = a+b+c

-- EJERCICIO 4e
-- !!! revisar
sumarSoloMultiplos :: (Integer, Integer, Integer) -> Integer -> Integer
sumarSoloMultiplos (a,b,c) n | (mult a n)&&(mult b n)&&(mult c n) = a+b+c
                             | (mult a n)&&(mult b n) = a+b
                             | (mult a n)&&(mult c n) = a+c
                             | (mult a n) = a
                             | (mult b n) = b
                             | (mult c n) = c
                             | otherwise = 0
                             where mult = esMultiploDe


-- EJERCICIO 4f
posPrimerPar :: (Integer, Integer, Integer) -> Integer
posPrimerPar (a,b,c) | mod a 2 == 0 = 0
                     | mod b 2 == 0 = 1
                     | mod c 2 == 0 = 2
                     | otherwise = 4

-- EJERCICIO 4g
crearPar :: a -> b -> (a,b)
crearPar a b = (a,b)

-- EJERCICIO 4h
invertir :: (a,b) -> (b,a)
invertir (a,b) = (b,a)

-- EJERCICIO 5
tmF :: Integer -> Integer
tmF n | n <= 7 = n^2
      | otherwise = 2*n -1

tmG :: Integer -> Integer
tmG n | (mod n 2) == 0 = div n 2
      | otherwise = 3*n + 1

todosMenores :: (Integer, Integer, Integer) -> Bool
todosMenores (a,b,c) = ((tmF a) > (tmG a))&&((tmF b) > (tmG b))&&((tmF c) > (tmG c))

-- EJERCICIO 6
type Anio = Integer
type EsBisiesto = Bool

bisiesto :: Anio -> EsBisiesto
bisiesto x | mod x 4 /= 0 = False
           | (mod x 100 == 0)&&(mod x 400 /= 0) = False
           | otherwise = True

-- EJERCICIO 7
distanciaManhattan :: Punto3D -> Punto3D -> Float
distanciaManhattan (a,b,c) (d,e,f) = abs(a-d) + abs(b-e) + abs(c-f)

-- EJERCICIO 8
sumaUltimosDosDigitos :: Integer -> Integer
sumaUltimosDosDigitos x = (digitoUnidades x) + (digitoDecenas x)

comparar :: Integer -> Integer -> Integer
comparar a b | (sumaUltimosDosDigitos a) < (sumaUltimosDosDigitos b) = 1
             | (sumaUltimosDosDigitos a) > (sumaUltimosDosDigitos b) = -1
             | (sumaUltimosDosDigitos a) == (sumaUltimosDosDigitos b) = 0

-- EJERCICIO 9
-- 9a. Si n=0, deuvelve el valor 1. Si n≠0, devuelve el valor 0.

-- 9b. Si n=1, devuelve 15. Si n=-1, devuelve -15. La función no está definida para R-\{-1, 1}

-- 9c. Si n<=9, devuelve 7. Si no es así, entonces se cumple la condición de que n>=3 y devuelve 5.

-- 9d. Toma dos números flotantes y devuelve la mitad de la suma de x, y.

-- 9e. Toma una tupla y devuelve la mitad de la suma de sus coordenadas.

-- 9f. Decide si es cierto que b es el entero más cercano entre 0 y a