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
        print(espacios + generar_seq_n(i))

def generar_seq_n(n: int):
    cadena: str = str(n)
    while n > 1:
        n -= 1
        cadena = str(n) + cadena + str(n)
    return cadena