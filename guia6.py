import math

# EJERCICIO 1.1
def imprimir_hola_mundo():
    print("¡Hola mundo!")

# EJERCICIO 1.2
def imprimir_un_verso():
    print("Dime qué debo cantar\nOh, algoritmo\nSé que lo sabes mejor\nIncluso que yo mismo")

# EJERCICIO 1.3
def raizDe2():
    raiz: float = math.sqrt(2)
    redondeado: float = round(raiz, 4)
    return redondeado

# EJERCICIO 1.4
def factorial_de_dos():
    return 2*1

# EJERCICIO 1.5
def perimetro():
    return 2 * math.pi

# EJERCICIO 2.1
def imprimir_saludo(nombre: str):
    print("Hola " + nombre)

# EJERCICIO 2.2
def raiz_cuadrada_de(numero: float):
    return math.sqrt(numero)

# EJERCICIO 2.3
def fahrenheit_a_celsius(temp_far: float):
    return ((temp_far - 32)*5)/9

# EJERCICIO 2.4
def imprimir_dos_veces(estribillo: str):
    return estribillo + "\n" + estribillo

# EJERCICIO 2.5
def es_multiplo_de(n: int, m: int):
    return n%m == 0

# EJERCICIO 2.6
def es_par(numero: int):
    return es_multiplo_de(numero, 2)

# EJERCICIO 2.7
def cantidad_de_pizzas(comensales: int, min_cant_de_porciones: int):
    porciones_necesarias = comensales * min_cant_de_porciones
    return math.ceil(porciones_necesarias / 8)

# EJERCICIO 3.1
def alguno_es_0(numero1: float, numero2: float):
    return (numero1 == 0) or (numero2 == 0)

# EJERCICIO 3.2
def ambos_son_0(numero1: float, numero2: float):
    return (numero1 == 0) and (numero2 == 0)

# EJERCICIO 3.3
def es_nombre_largo(nombre: int):
    return (3 <= len(nombre)) and (len(nombre) <= 8)

# EJERCICIO 3.4
def es_bisiesto(año: int):
    return (es_multiplo_de(año, 400)) or (es_multiplo_de(año, 4) and (not es_multiplo_de(año, 100)))

