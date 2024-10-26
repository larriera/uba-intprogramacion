# REVISAR:
# * no modificar listas pasadas como 'in'

import copy
import random

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
    hay_orden: bool = True
    i: int = 0
    while (i < len(s) - 1) & hay_orden:
        if s[i] > s[i+1]:
            hay_orden = False
        i += 1
    return hay_orden

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
        if s[i] == s[i+1] == s[i+2]:
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
    if len(res) < len(s): #para no irnos de rango
        for i in range(len(s) - len(res)):
            res.append(True)
    for i in range(len(s)):
        if pertenece(s[i], e):
            res[i] = True
        else:
            res[i] = False

# EJERCICIO 5.2
def pertenece_a_cada_uno_version_2(s: list[list[int]], e: int, res: list[bool]):
    if len(res) < len(s): #para no irnos de rango
        for i in range(len(s) - len(res)):
            res.append(True)
    if len(res) > len(s): #asegura |s| = |res|
        for i in range(len(s) - len(res)):
            res.pop(i)
    for i in range(len(s)):
        if pertenece(s[i], e):
            res[i] = True
        else:
            res[i] = False

# EJERCICIO 5.3
def pertenece_a_cada_uno_version_3(s: list[list[int]], e: int) -> list[bool]:
    res: list[bool] = []
    for i in range(len(s)):
        if pertenece(s[i], e):
            res.append(True)
        else:
            res.append(False)
    return res

# EJERCICIO 6.1
def es_matriz(s: list[list[int]]) -> bool:
    res: bool = True
    i: int = 1
    while res & (i < len(s)):
        if len(s[0]) != len(s[i]):
            res = False
        i += 1
    return res

# EJERCICIO 6.2
def filas_ordenadas(m: list[list[int]], res: list[bool]):
    for i in range(len(m)):
        print(res)
        if ordenados(m[i]):
            res[i] = True
        else:
            res[i] = False

# EJERCICIO 6.3
def columna(m: list[list[int]], c: int) -> list[int]:
    elem_pos_c: list = []
    for i in m:
        elem_pos_c.append(i[c])
    return elem_pos_c

# EJERCICIO 6.4
def columnas_ordenadas(m: list[list[int]]) -> bool:
    hay_orden: bool = True
    i: int = 0
    while (i < len(m[0])) & hay_orden:
        if not (ordenados(columna(m,i))):
            hay_orden = False
        i += 1
    return hay_orden

# EJERCICIO 6.5
def transponer(m: list[list[int]]) -> list[list[int]]:
    m_t: list = []
    for i in range(len(m[0])):
        m_t.append(columna(m, i))
    return m_t

# EJERCICIO 6.6
def quien_gana_tateti(m:list[list[str]]) -> int:
    gana: str = "N"
    i: int = 0
    while (i < 3) & (gana == "N"): # freno si encuentro ganador
        if m[i][0] == m[i][1] == m[i][2]: # horizontal
            gana = m[i][0]
        elif m[0][i] == m[1][i] == m[2][i]: # vertical
            gana = m[0][i]
        i += 1
    if (gana == "N") & ((m[0][0] == m[1][1] == m[2][2]) | (m[0][2] == m[1][1] == m[2][0])): # si no encontre ganador en hor o ver, entonces reviso las diagonales
        gana = m[1][1] #por especificacion, si hay ganador diag solo una de las diagonales tendra los simbolos ganadores. como no me importa en que diagonal se gano, reviso el simbolo del centro del tablero (que necesariamente estara en la diag ganadora)
    # defino que tengo que devolver:
    res: int = 2
    if gana == "O":
        res = 0
    elif gana == "X":
        res = 1
    return res

# EJERCICIO 7.1
def listar_alumnos() -> list:
    lista: list = []
    nuevo_alumno: str = "n"
    while (nuevo_alumno != "listo") & (nuevo_alumno != ""):
        lista.append(nuevo_alumno)
        nuevo_alumno = input("Nombre del alumno --> ")
    lista.pop(0)
    return lista

# EJERCICIO 7.2
def monedero() -> list:
    historial: list = []
    accion: str = ""
    monto: float = 0
    while accion != 'X':
        accion = input("Ingrese C para cargar, D para descontar o X para salir: ")
        if accion != 'X' :
            monto = input("Ingrese el monto: ")
            historial.append((accion, monto))
            print("Movimiento guardado.")
    return historial

# EJERCICIO 7.3
def sieteymedio() -> list:
    historial: list = []
    total: int = 0
    cartas: list = [1,2,3,4,5,6,7,10,11,12]
    carta_nueva: int = 0
    se_planta: str = "N"
    while se_planta == "N":
        carta_nueva = random.choice(cartas)
        historial.append(carta_nueva)
        if carta_nueva < 10:
            total += carta_nueva
        else:
            total += 0.5
        print("Sale una carta con el valor " + str(carta_nueva) + ". Vas sumando " + str(total) + " puntos.")
        if total <= 7.5:
            se_planta = input("¿Te plantás? (S/N)   ")
        else:
            print("Ufa, te pasaste. Perdiste.")
            se_planta = "S"
    print("Este es tu historial de cartas:")
    print(historial)
    return historial

# EJERCICIO 7.4
def fortaleza_pwd():
    pwd: str = input("Ingrese su contraseña: ")
    print(analizar_pwd(pwd))
    return analizar_pwd(pwd)

def analizar_pwd(pwd: str) -> str:
    res: str = "AMARILLA"
    if len(pwd) < 5:
        res = "ROJA"
    elif (len(pwd) > 8) & tiene_minuscula(pwd) & tiene_mayuscula(pwd) & tiene_elem_de(pwd, "0123456789"):
        res = "VERDE"
    return res

def tiene_elem_de(s: list, elems: list) -> bool:
    tiene: bool = False
    i: int = 0
    while (i < len(s)) & (not tiene):
        if s[i] in elems:
            tiene = True
        i += 1
    return tiene

def tiene_minuscula(txt: str) -> bool:
    return tiene_elem_de(txt, "abcdefghijklmnñopqrstuvwxyz")

def tiene_mayuscula(txt: str) -> bool:
    return tiene_elem_de(txt, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ")
