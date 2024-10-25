import copy

# EJERCICIOS ADICIONALES 2024-10-14

# 1+1 | 1+2 | 1+3 | ... | 1+c
# 2+1 | 2+2 | 2+3 | ... | 2+c
# ...   ...   ...   ...   ...
# f+1 | f+2 | f+3 | ... | f+c

def suma_matriz_fila_col(f: int, c: int) -> int:
    suma_total: int = 0
    for i in range(1,f+1):
        for j in range(1,c+1):
            suma_total += i + j
    return suma_total

def piramide_de_numeros(n: int):
    for i in range(1,n+1):
        espacios: str = " "*(n-i)
        print(espacios + generar_sec_n(i))

def generar_sec_n(n: int) -> str:
    cadena: str = str(n)
    while n > 1:
        n -= 1
        cadena = str(n) + cadena + str(n)
    return cadena

# EJERCICIO 1.1
def pertenece(s: list[int], e: int) -> bool:
    perte: bool = False
    i: int = 0
    while (i < len(s)) & (not perte):
        if s[i] == e:
            perte = True
        i += 1
    return perte

# EJERCICIO 1.2
def divide_a_todos(s: list[int], e: int) -> bool:
    divide: bool = True
    i: int = 0
    while (i < len(s)) & divide:
        if (s[i] % e) != 0:
            divide = False
        i += 1
    return divide

# EJERCICIO 1.3
def suma_total(s: list[int]) -> int:
    suma: int = 0
    for i in range(len(s)):
        suma += s[i]
    return suma

# EJERCICIO 1.4
def maximo(s: list[int]) -> int:
    max: int = s[0]
    for i in range(len(s)):
        if s[i] > max:
            max = s[i]
    return max

# EJERCICIO 1.5
def minimo(s: list[int]) -> int:
    min: int = s[0]
    for i in range(len(s)):
        if s[i] < min:
            min = s[i]
    return min

# EJERCICIO 1.6
def ordenados(s: list[int]) -> bool:
    es_orden: bool = True
    i: int = 0
    while (i < len(s)) & es_orden:
        if s[i] > s[i+1]:
            es_orden = False
    return es_orden

# EJERCICIO 1.7
def pos_maximo(s: list[int]) -> int:
    pos: int = -1
    i: int = 0
    while (i < len(s)):
        if s[i] == maximo(s):
            pos = i
            i = len(s) #corto el ciclo cuando encuentro la primera aparicion
        i += 1
    return pos

# EJERCICIO 1.8 - aca cambio la implementacion porque pide especificamente la ultima aparicion     
def pos_minimo(s: list[int]) -> int:
    pos: int = -1
    i: int = 0
    while i < len(s):
        if s[i] == minimo(s):
            pos = i
        i += 1
    return pos

# EJERCICIO 1.9
def hay_mayor_a_7(s: list[str]) -> bool:
    hay_mayor: bool = False
    i: int = 0
    while (i < len(s)) & (not hay_mayor):
        print(i)
        if len(s[i]) > 7:
            hay_mayor = True
        i += 1
    return hay_mayor

# EJERCICIO 1.10
def palindromo(texto: str) -> bool:
    return texto == lista_a_cadena(reves(texto))

# AUX: devuelve la misma lista "dada vuelta"
def reves(s: list) -> list:
    lista_reves = []
    for i in range((len(s)-1), -1, -1):
        lista_reves.append(s[i])
    return lista_reves

# AUX: toma todos los elementos de una lista y los pone en una cadena
def lista_a_cadena(lista: list) -> str:
    cadena = ""
    for i in range(len(lista)):
        cadena += str(lista[i])
    return cadena

# EJERCICIO 1.11
def tres_consecutivos(s: list[int]) -> bool:
    hay_consec: bool = False
    i: int = 0
    while (i < (len(s) - 3)) & (not hay_consec):
        print(i)
        if (s[i] == s[i+1]) & (s[i] == s[i+2]):
            hay_consec = True
        i += 1
    return hay_consec

# EJERCICIO 1.12
def vocales_distintas(palabra: str) -> bool:
    hay_distintas: bool = True
    vocales: str = "AEIOUaeiou"
    mis_vocales: str = sin_rep(filtrar_lista(palabra, vocales))
    if len(mis_vocales) < 3:
        hay_distintas = False
    return hay_distintas

# AUX: quita todos los elementos de s que no pertenezcan a elems
def filtrar_lista(s: list, elems: list) -> list:
    filtrada = []
    for i in s:
        if i in elems:
            filtrada.append(i)
    return filtrada

# AUX: devuelve una lista con los elementos unicos de s
def sin_rep(s: list) -> list:
    lista_unica = []
    i: int = 0
    while i < len(s):
        if not (s[i] in lista_unica):
            lista_unica.append(s[i])
        i += 1
    return lista_unica

# EJERCICIO 1.13
def pos_sec_mas_larga(s: list[int]) -> int:
    secuencias: list = []
    posiciones: list = [0]
    sec_actual: list = []
    # listamos todas las secuencias ordenadas
    for i in range(len(s)-1):
        sec_actual.append(s[i])
        if s[i] > s[i+1]:
            secuencias.append(sec_actual)
            posiciones.append(i+1)
            sec_actual = []
    # buscamos cual es la secuencia ordenada mas larga
    i_sec_mas_larga: int = 0
    for i in range(len(secuencias)-1):
        if len(secuencias[i+1]) > len(secuencias[i]):
            i_sec_mas_larga = i+1
    return posiciones[i_sec_mas_larga]

# EJERCICIO 1.14
def cantidad_digitos_impares(s: list[int]) -> int:
    cant: int = 0
    for i in s:
        cant += digitos_impares(i)
    return cant

# AUX: cuenta los digitos impares de un numero
def digitos_impares(n: int) -> int:
    cant: int = 0
    while n != 0:
        print(n)
        if n%2 == 1:
            cant += 1
        n = n // 10
    return cant

# EJERCICIO 2.1
def CerosEnPosicionesPares(s: list[int]):
    for i in range(len(s)):
        if i%2 == 0:
            s[i] = 0

# EJERCICIO 2.2
def CerosEnPosicionesPares2(s: list[int]) -> list[int]:
    l: list = copy.copy(s)
    for i in range(len(s)):
        if i%2 == 0:
            l[i] = 0
    return l

# x: list = [1,1,1,1]
# print(x)
# y = CerosEnPosicionesPares2(x)
# print(y)
# print(x)

# EJERCICIO 2.3
def sin_vocales(s: str) -> str:
    vocales: str = "aeiouAEIOU"
    sin_v: str = ""
    for i in s:
        if not (i in vocales):
            sin_v += i
    return sin_v

# EJERCICIO 2.4
def reemplaza_vocales(s: str) -> str:
    vocales: str = "aeiouAEIOU"
    sin_v: str = ""
    for i in s:
        if i in vocales:
            sin_v += "_"
        else:
            sin_v += i
    return sin_v

# EJERCICIO 2.5
def da_vuelta_str(s: str) -> str:
    dado_vuelta: int = ""
    for i in reves(s):
        dado_vuelta += i
    return dado_vuelta

# EJERCICIO 3
def resultadoMateria(notas: list[int]) -> int:
    resultado: int = 0
    prom: float = promedio(notas)
    if (not todo_aprobado(notas)) | (prom < 4):
        resultado = 3
    elif prom < 8:
        resultado = 1
    else:
        resultado = 2
    return resultado

# AUX: dada una lista de notas, evalua que todas sean mayor igual a 4
def todo_aprobado(notas: list[int]) -> bool:
    aprobado: bool = True
    i: int = 0
    while (i < len(notas)) & aprobado:
        if notas[i] < 4:
            aprobado = False
        i += 1
    return aprobado

# AUX: dada una lista de numeros, calcula el promedio
def promedio(s: list) -> float:
    prom: float = 0.0
    for i in s:
        prom += i
    prom = prom / len(s)
    return round(prom, 2)

# EJERCICIO 4
def saldo_actual(movimientos: list[tuple]) -> int:
    saldo: int = 0
    for mov in movimientos:
        if mov[0] == "I":
            saldo += mov[1]
        if mov[0] == "R":
            saldo -= mov[1]
    return saldo

# EJERCICIO 5.1
def pertenece_a_cada_uno_version_1(s: list[list[int]], e: int, res: list[bool]):
    for i in range(len(s)):
        if pertenece(s[i], e):
            res[i] = True
        else:
            res[i] = False

# test: list[bool] = [True]*7
# print("Estado inicial:")
# print(test)
# print("Llamo la funcion:")
# pertenece_a_cada_uno_version_1([[1],[0],[1],[1],[0],[0],[0]], 1, test)
# print("Estado final:")
# print(test)

# EJERCICIO 5.2 - es la misma especificación que el anterior?

# EJERCICIO 5.3
def pertenece_a_cada_uno_version_3(s: list[list[int]], e: int) -> list[bool]:
    res: list[bool] = []
    for i in range(len(s)):
        if pertenece(s[i], e):
            res.append(True)
        else:
            res.append(False)
    return res

