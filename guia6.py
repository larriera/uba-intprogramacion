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

# EJERCICIO 4
def peso_pino(altura: float):
    altura_en_cm: int = math.floor(altura * 100)
    peso: int = 0
    i: int = 0
    while i < altura_en_cm:
        if i < 300:
            peso += 3
        else:
            peso += 2
        i += 1
    return peso

def es_peso_util(peso: float):
    return (400 <= peso) and (peso <= 1000)

def sirve_pino(altura: float):
    return es_peso_util(peso_pino(altura))

# EJERCICIO 5.1
def devolver_el_doble_si_es_par(numero: int) -> int:
    return 2 * numero if es_par(numero) else numero

# EJERCICIO 5.2
def devolver_valor_si_es_par_sino_el_que_sigue(numero: int) -> int:
    if es_par(numero):
        return numero
    return numero + 1

# EJERCICIO 5.3
def devolver_el_doble_si_es_multiplo3_el_triple_si_es_multiplo9(numero: int) -> int:
    if es_multiplo_de(numero, 9):
        return 3*numero
    elif es_multiplo_de(numero, 3):
        return 2*numero
    return numero

# EJERCICIO 5.4
def lindo_nombre(nombre: str) -> str:
    if len(nombre) >= 5:
        return "Tu nombre tiene muchas letras!"
    return "Tu nombre tiene menos de 5 caracteres"

# EJERCICIO 5.5
def elRango(numero: float):
    if numero < 5:
        print("Menor a 5")
    if (numero >= 10) & (numero <= 20):
        print("Entre 10 y 20")
    if numero > 20:
        print("Mayor a 20")

# EJERCICIO 5.6
def vacaciones(sexo: str, edad: int):
    if (edad < 18) | ((sexo == "F")&(edad >= 60)) | ((sexo == "M")&(edad >= 65)):
        print("Andá de vacaciones")
    else:
        print("Te toca trabajar")

