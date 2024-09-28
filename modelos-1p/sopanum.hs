module SopaNum where

{--
======================================
SOPA DE NUMEROS
======================================

Una sopa de numeros es un juego que consiste en descubrir propiedades de un tablero de dimensiones n × m con n y
m > 0, en los que en cada posicion hay un numero entero positivo. Cada posicion se identifica con una dupla (i, j) en el cual
la primera componente corresponde a una fila y la segunda a una columna. A modo de ejemplo, la siguiente figura muestra
un tablero de 5 × 4 en el que el numero 13 aparece en la posicion (1, 1) y el numero 5 aparece en la posicion (4, 3). Notar
que tanto la numeracion de las filas como la de las columnas comienzan en 1.

+----+----+----+----+
|*13*| 12 |  6 |  4 |
+----+----+----+----+
| 11 |  1 | 32 | 25 |
+----+----+----+----+
|  9 |  2 | 14 |  7 |
+----+----+----+----+
|  7 |  3 | *5*| 16 |
+----+----+----+----+
| 27 |  2 |  8 | 18 |
+----+----+----+----+

Un camino en un tablero esta dado por una secuencia de posiciones adyacentes en la que solo es posible desplazarse
desde una posicion dada hacia la posicion de su derecha o hacia la que se encuentra debajo. En otras palabras, un camino
de longitud l en un tablero se define como una secuencia con l posiciones, ordenadas de manera tal que el elemento i-esimo
es la posicion resultante de haberse movido hacia la derecha o hacia abajo desde la posicion (i-1)-esima.

Para manipular las sopas de numeros en Haskell vamos a representar el tablero como una lista de filas de igual longitud.
A su vez, cada fila vamos a representarla como una lista de enteros positivos. Las posiciones vamos a representarlas con
tuplas de dos numeros enteros positivos y un camino va a estar dado por una lista de posiciones.
Para implementar esta sopa de numeros nos enviaron las siguientes especificaciones y nos pidieron que hagamos el desa-
rrollo enteramente en Haskell, utilizando los tipos requeridos y solamente las funciones que se ven en la materia Introduccion
a la Programacion / Algoritmos y Estructuras de Datos I (FCEyN-UBA).


Asumimos los siguientes renombres de tipos de datos en las especificaciones de los ejercicios:
Fila = seq⟨Z⟩
Tablero = seq⟨F ila⟩
Posicion = Z × Z – Observacion: las posiciones son: (fila, columna)
Camino = seq⟨Posicion⟩
--}

type Fila = [Int]
type Tablero = [Fila]
type Posicion = (Int, Int) -- (n fila, m columna)
type Camino = [Posicion]

{--
problema maximo (t: Tablero) : Z {
requiere: {El tablero t es un tablero bien formado, es decir, la longitud de todas las filas es la misma, y tienen al
menos un elemento}
requiere: {Existe al menos una columna en el tablero t }
requiere: {El tablero t no es vacio, todos los numeros del tablero son positivos, mayor estricto a 0}
asegura: {res es igual al numero mas grande del tablero t}
}
--}

maximo :: Tablero -> Int
maximo [f] = numMax f
maximo (f:g:fs)
    | numMax f >= numMax g = maximo (f:fs)
    | otherwise = maximo (g:fs)

-- AUX: devuelve el numero mayor de una fila
numMax :: Fila -> Int
numMax [] = 0
numMax [x] = x
numMax (x:y:xs)
    | x >= y = numMax (x:xs)
    | otherwise = numMax (y:xs)

----------------------------------------------

{--
problema masRepetido (t: Tablero) : Z {
requiere: {El tablero t es un tablero bien formado, es decir, la longitud de todas las filas es la misma, y tienen al
menos un elemento}
requiere: {Existe al menos una columna en el tablero t }
requiere: {El tablero t no es vacio, todos los numeros del tablero son positivos, mayor estricto a 0}
asegura: {res es igual al numero que mas veces aparece en un tablero t. Si hay empate devuelve cualquiera de ellos}
}
--}

masRepetido :: Tablero -> Int
masRepetido [f] = masApariciones f
masRepetido (f:fs) = masApariciones todosLosNum
    where todosLosNum = aplanarTablero (f:fs)

-- AUX: concatena todas las filas de un tablero en una sola lista
aplanarTablero :: Tablero -> Fila
aplanarTablero [] = []
aplanarTablero [f] = f
aplanarTablero (f:fs) = f ++ aplanarTablero fs

-- AUX: cuenta las apariciones de un numero en una fila
apariciones :: Fila -> Int -> Int
apariciones [] _ = 0
apariciones (x:xs) e
    | x == e = 1 + apariciones xs e
    | otherwise = apariciones xs e

-- AUX: devuelve el numero que mas veces aparece en una fila
masApariciones :: Fila -> Int
masApariciones [] = (-1)
masApariciones [x] = x
masApariciones (x:y:xs)
    | apariciones (x:y:xs) x >= apariciones (x:y:xs) y = masApariciones (x:xs)
    | otherwise = masApariciones (y:xs)

----------------------------------------------

{--
problema valoresDeCamino (t: Tablero, c: Camino) : seq⟨Z⟩ {
requiere: {El tablero t es un tablero bien formado, es decir, la longitud de todas las filas es la misma, y tienen al
menos un elemento}
requiere: {Existe al menos una columna en el tablero t }
requiere: {El tablero t no es vacio, todos los numeros del tablero son positivos, mayor estricto a 0}
requiere: {El camino c es un camino valido, es decir, secuencia de posiciones adyacentes en la que solo es posible
desplazarse hacia la posicion de la derecha o hacia abajo y todas las posiciones estan dentro de los limites del tablero
t}
asegura: {res es igual a la secuencia de numeros que estan en el camino c, ordenados de la misma forma que aparecen
las posiciones correspondientes en el camino.}
}
--}

valoresDeCamino :: Tablero -> Camino -> [Int]
valoresDeCamino t [] = []
valoresDeCamino t [p] = [encontrarNum t p]
valoresDeCamino t (p:ps) = (encontrarNum t p):(valoresDeCamino t ps)

-- AUX: devuelve fila segun posicion
posPorFila :: Tablero -> Posicion -> Int -> Fila
posPorFila [] _ _ = []
posPorFila (f:fs) (p1,p2) i -- invocar con i=1
    | p1 == i = f
    | otherwise = posPorFila fs (p1,p2) (i+1)

-- AUX: devuelve el numero en cierta posicion de una fila
posPorColumna :: Fila -> Posicion -> Int -> Int
posPorColumna [] _ _ = -1
posPorColumna (x:xs) (p1,p2) i -- al invocar, i=1
    | p2 == i = x -- estamos en la columna p2
    | otherwise = posPorColumna xs (p1,p2) (i+1) -- nos fijamos si la columna p2 es la siguiente

-- AUX: devuelve el numero en cierta posicion de un tablero
encontrarNum :: Tablero -> Posicion -> Int
encontrarNum [] _ = -1
encontrarNum (f:fs) (p1,p2) = posPorColumna (fila) (p1,p2) 1
    where fila = posPorFila (f:fs) (p1,p2) 1

{--
-- AUX: devuelve el numero en cierta posicion de un tablero
encontrarNum :: Tablero -> Posicion -> Int -> Int
encontrarNum [] _ _ = -1
encontrarNum (f:fs) (p1,p2) i -- al invocar, i=1
    | p1 == i = posPorColumna f (p1,p2) 1 -- estamos en la fila p1
    | otherwise = encontrarNum fs (p1,p2) (i+1) -- nos fijamos si la fila p1 es la siguiente
--}