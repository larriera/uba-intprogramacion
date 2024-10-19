import math

def testear_ej1():
    print("~~~ 1.1 ~~~")
    imprimir_hola_mundo()
    print("~~~ 1.2 ~~~")
    imprimir_un_verso()
    print("~~~ 1.3 ~~~")
    print(raizDe2())
    print("~~~ 1.4 ~~~")
    print(factorial_de_dos())
    print("~~~ 1.5 ~~~")
    print(perimetro())

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

testear_ej1()