from queue import Queue as Cola
from queue import LifoQueue as Pila

# Segundo Parcial - Introducción a la Programación, 2C 2024
# Tema 2 - Turno mañana

# Este es el parcial que me tocó en mi cursada. El único ejercicio que no pasó todos los
# test es el 1, malinterpreté la especificación. Dejo abajo los test que fallarron en la
# corrección. Igualmente no garantizo que el resto de mi solución sea la más 
# eficiente/elegante etc etc etc

# Nota: 9.15 / 10.0 (APROBADO)
# puntaje ej1: 1.4
# puntaje ej2: 2.25
# puntaje ej3: 2.25
# puntaje ej4: 2.25
# puntaje ej5: 1

# ----------------------------------------------------

# Ejercicio 1 (2,25 puntos)
# Implementar la función subsecuencia_mas_larga especificada (todos_consecutivos no es testeado)

# problema subsecuencia_mas_larga (in v: seq⟨Z⟩) : ZxZ {
#   requiere: { La longitud de v es distinto de 0 }
#   asegura: { Sea x la primera subsecuencia más larga en v tal que vale todos_consecutivos(x), la primera componente de res es igual a |x| y la segunda es igual al índice en v donde comenzaría x }
# }

# problema todos_consecutivos (in v: seq⟨Z⟩) : Bool {
#   asegura: { res == True <==> cada par de elementos adyacentes en v son números consecutivos, es decir, que su diferencia es igual a 1 }
# }


# TESTS FALLIDOS:

# FAIL: test_baja
# entrada: [3, 2, 1]
# salida esperada: (3, 0)

# FAIL: test_empates
# entrada: [-10, 2,1,2,1, 1,2,1,2]
# salida esperada: (4, 1)

# FAIL: test_una_solucion_full
# entrada: [-2, -1, 0, 1, 0, -1, 0, 1, 2, 3]
# salida esperada: (10, 0)

def subsecuencia_mas_larga(v: list[int]) -> tuple[int,int]:
    subsecs: list[list[int]] = []
    inicios: list[int] = []
    s_actual: list[int] = []
    i_actual: int = 0
    for i in range(len(v) - 1): #por especificacion, len(v) >= 0, asi que no genera conflictos
        s_actual.append(v[i])
        if (v[i+1] - v[i]) != 1: #fin de la subsecuencia
            subsecs.append(s_actual)
            s_actual = []
            inicios.append(i_actual)
            i_actual = i+1
    #agrego la ultima subsecuencia
    s_actual.append(v[len(v) - 1])
    subsecs.append(s_actual)
    inicios.append(i_actual)
    #busco los datos de la primera subsecuencia mas larga
    len_mas_larga: int = len(subsecs[0])
    i_mas_larga: int = 0
    for i in range(len(subsecs)):
        if len(subsecs[i]) > len_mas_larga:
            len_mas_larga = len(subsecs[i])
            i_mas_larga = inicios[i]
    return (len_mas_larga, i_mas_larga)

# ----------------------------------------------------

# Ejercicio 2 (2,25 puntos)
# Ana tiene exámenes de respuesta Verdadero ó Falso. Ella sabe que en cada examen la cantidad 
# de respuestas correctas cuyo valor es Falso es igual a la cantidad de respuestas correctas 
# cuyo valor es Verdadero. Tenemos el historial de las respuestas de cada exámen dados por Ana 
# en una cola. En cada uno Ana respondió todas las preguntas.

# problema mejor_resultado_de_ana (in examenes: Cola⟨ seq⟨Bool⟩ ⟩) : seq⟨Z⟩ {
#   requiere:{ Cada elemento de examenes es no vacío y tiene longitud par }
#   asegura: { res tiene la misma cantidad de elementos que examenes }
#   asegura: { res[i] es igual a la máxima cantidad de respuestas correctas que Ana podría haber respondido en el i-ésimo exámen resuelto en examenes, para 0 <= i < cantidad de elementos de examenes }
# }

def mejor_resultado_de_ana(examenes: Cola[list[bool]]) -> list[int]:
    examenes_copia: Cola[list[bool]] = Cola() #armo una copia para poder reconstruir examenes al finalizar
    resultados: list[int] = []
    while not examenes.empty():
        examen: list[bool] = examenes.get()
        resultados.append(max_correctas(examen))
        examenes_copia.put(examen)
    #reconstruyo examenes
    while not examenes_copia.empty():
        examenes.put(examenes_copia.get())
    return resultados

# AUX: dado un examen en formato lista de booleanos, devuelve la cantidad maxima de respuestas correctas posibles, sabiendo que
# cant. de T correctas = cant. de F correctas = |examen| / 2
def max_correctas(examen: list[bool]) -> int:
    cant_t: int = 0
    cant_f: int = 0
    for i in examen:
        if i:
            cant_t += 1
        else:
            cant_f += 1
    if cant_t > (len(examen) // 2):
        cant_t = len(examen) // 2
    if cant_f > (len(examen) // 2):
        cant_f = len(examen) // 2
    return cant_t + cant_f

# ----------------------------------------------------

# Ejercicio 3 (2,25 puntos)
# problema cambiar_matriz(inout A: seq⟨seq⟨Z⟩⟩) {
#   requiere: { Todas las filas de A tienen la misma longitud }
#   requiere: { El mínimo número que aparece en A es igual a 1 }
#   requiere: { El máximo número que aparece en A es igual a #filas de A por #columnas de A }
#   requiere: { No hay enteros repetidos en A }
#   requiere: { Existen al menos dos enteros distintos en A }
#   modifica: { A }
#   asegura: { A tiene exactamente las mismas dimensiones que A@pre }
#   asegura: { El conjunto de elementos que aparecen en A es igual al conjunto de elementos que aparecen en A@pre }
#   asegura: { A[i][j] != A@pre[i][j] para todo i, j en rango }
# }

def cambiar_matriz(A: list[list[int]]) -> None:
    elems: list[int] = listar_elems_matriz(A)
    elems.append(elems.pop(0)) #cambio el orden de los elementos
    i: int = 0
    while i < len(elems):
        for f in range(len(A)):
            for c in range(len(A[0])):
                A[f][c] = elems[i]
                i += 1

# AUX: requiere matriz no vacia
def listar_elems_matriz(matriz: list[list[int]]) -> list[int]:
    elems: list[int] = []
    for f in range(len(matriz)):
        for c in range(len(matriz[0])):
            elems.append(matriz[f][c])
    return elems

# ----------------------------------------------------

# Ejercicio 4 (2,25 puntos)
# Tenemos un texto que contiene palabras. Por simplicidad, las palabras están separadas únicamente por uno o más espacios.

# problema palabras_por_vocales (in texto: string): Diccionario⟨Z,Z⟩ {
#   requiere: { Si existe una letra vocal en texto, esta no lleva tildes, diéresis, ni ningún otro símbolo }
#   asegura: { Si existe una palabra en texto con x vocales en total, x es clave de res }
#   asegura: { Las claves de res representan la cantidad total de vocales de una palabra, y cada valor corresponde a la cantidad de palabras en texto con ese número de vocales. }
#   asegura: { Los valores de res son positivos }
# }

def palabras_por_vocales(texto: str) -> dict[int, int]:
    palabras: list[str] = listar_palabras(texto)
    d: dict[int,int] = {}
    for p in palabras:
        cant_voc: int = cant_vocales(p)
        if pertenece(list(d.keys()), cant_voc):
            d[cant_voc] += 1
        else:
            d[cant_voc] = 1
    return d

# AUX: devuelve la cantidad de vocales (sin simbolos) de una palabra
def cant_vocales(palabra: str) -> int:
    cant: int = 0
    vocales: str = "aeiouAEIOU"
    for i in palabra:
        if pertenece(vocales, i):
            cant += 1
    return cant

# AUX: pertenece (elegi hacerlo de tipo generico para poder reutilizarlo)
def pertenece(s:list, e) -> bool:
    pert: bool = False
    i: int = 0
    while (not pert) and (i < len(s)):
        if s[i] == e:
            pert = True
        i += 1
    return pert

# AUX: toma como separador a " "
def listar_palabras(texto:str) -> list[str]:
    palabras: list[str] = []
    p_actual: str = ""
    for i in texto:
        if (i == " "):
            palabras.append(p_actual)
            p_actual = ""
        else:
            p_actual += i
    palabras.append(p_actual)
    #limpio la lista
    sin_vacios: list[str] = []
    for i in palabras:
        if i != '':
            sin_vacios.append(i)
    return sin_vacios

# ----------------------------------------------------

# Ejercicio 5 (1 punto)
# ¿Por qué en Paradigma Imperativo no existe la transparencia referencial?
# [ ] Utilizamos otro mecanismo de repetición de código, en lugar de recursión usamos la iteración (FOR, WHILE, DO WHILE).
# [x] Tenemos una nueva instrucción, la asignación, que nos permite cambiar el valor de una variable
# [ ] El orden en que se ejecutan las instrucciones del programa es diferente