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