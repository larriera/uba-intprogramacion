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
    for i in range(len(s)):
        if s[i] == e:
            return True
    return False

# EJERCICIO 1.2
def divide_a_todos(s: list[int], e: int) -> bool:
    for i in range(len(s)):
        if (s[i] % e) != 0:
            return False
    return True

# EJERCICIO 1.3
def suma_total(s: list[int]) -> int:
    suma = 0
    for i in range(len(s)):
        suma += s[i]
    return suma

# EJERCICIO 1.4
def maximo(s: list[int]) -> int:
    max = s[0]
    for i in range(len(s)):
        if s[i] > max:
            max = s[i]
    return max

# EJERCICIO 1.5
def minimo(s: list[int]) -> int:
    min = s[0]
    for i in range(len(s)):
        if s[i] < min:
            min = s[i]
    return min

