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

# ======================================
# RECORRIDO Y BUSQUEDA EN SECUENCIAS
# ======================================

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

def reves(s: list) -> list:
    lista_reves = []
    for i in range((len(s)-1), -1, -1):
        lista_reves.append(s[i])
    return lista_reves

def lista_a_cadena(lista: list) -> str:
    cadena = ""
    for i in range(len(lista)):
        cadena += str(lista[i])
    return cadena