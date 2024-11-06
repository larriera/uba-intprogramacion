from queue import LifoQueue as Pila
from queue import Queue as Cola
import random
import copy

# EJERCICIO 1
def generar_pila_al_azar(cantidad: int, desde: int, hasta: int) -> Pila[int]:
    p: Pila = Pila(cantidad)
    while not (p.full()):
        print(p.queue)
        p.put(random.randint(desde, hasta))
    print("DEVUELVE:")
    print(p.queue)
    return p

# EJERCICIO 2
def cant_elementos_pila(p: Pila) -> int:
    p_copia: Pila = Pila()
    cant: int = 0
    while not p.empty():
        e: int = p.get()
        p_copia.put(e)
        cant += 1
    while not p_copia.empty(): #restauro la pila original
        p.put(p_copia.get())
    return cant

#pilatest = generar_pila_al_azar(5,0,15)

# EJERCICIO 3
def buscar_el_max_pila(p: Pila[int]) -> int:
    p_copia: Pila = Pila()
    max: int = p.get()
    p_copia.put(max)
    while not p.empty():
        e: int = p.get()
        if e > max:
            max = e
        p_copia.put(e)
    while not p_copia.empty(): #restauro la pila original
        p.put(p_copia.get())
    print(max)
    print(p_copia.queue)
    print(p.queue)
    return max

# EJERCICIO 4
def buscar_nota_maxima(p: Pila[tuple[str,int]]) -> Pila[int]:
    p_copia: Pila = Pila()
    nota_max: tuple = ("", -1)
    while not p.empty():
        nota: tuple = p.get()
        if nota[1] > nota_max[1]:
            nota_max = nota
        p_copia.put(nota)
    while not p_copia.empty():
        p.put(p_copia.get())
    return nota_max

# EJERCICIO 5
def esta_bien_balanceada(s: str) -> bool:
    p: Pila = Pila()
    p_copia: Pila = Pila()
    esta_bien: bool = True
    for i in s:
        if i == "(" or i == ")":
            p.put(i)
            p_copia.put(i) #armo dos copias de la pila de parentesis
    cant_cierran: int = 0
    while (not p.empty()) and esta_bien: # si esta bien balanceado, p deberia ser de la pinta ((((()))))
        e: str = p.get()
        p_copia.get()
        if e == ")":
            cant_cierran += 1
        else:
            p_copia.put(e) #laburo en la copia asi no se rompe la condicion del while
            esta_bien = cant_elementos_pila(p_copia) == cant_cierran
    return esta_bien

# print(esta_bien_balanceada("1 + ( 2 x 3 − ( 2 0 / 5 ) )"))
# print(esta_bien_balanceada("1 + ( 2 x 3 − ( 2 0 / 5 ) ))"))
# print(esta_bien_balanceada("10 ∗ ( 1 + ( 2 ∗ ( −1)))"))
# print(esta_bien_balanceada("1 + ) 2 x 3 ( ( )"))

# EJERCICIO 6
def aplicar_operacion(oper: str, n1: float, n2: float) -> float:
    res: float = 0.0
    if oper == "+":
        res = n1 + n2
    elif oper == "-":
        res = n1 - n2
    elif oper == "*":
        res = n1 * n2
    elif oper == "/":
        res = n1 / n2
    return res

def evaluar_expresion(s: str) -> float:
    expresion: list = []
    elem: str = ""
    # construyo una lista con las partes de la expresion
    for i in s:
        print(i)
        if i == " ":
            expresion.append(elem)
            elem = ""
        else:
            elem += i
    expresion.append(elem) 
    operadores: str = "+-*/"
    pila: Pila = Pila()
    print(expresion)
    for i in expresion:
        print(pila.queue)
        print(i)
        if i in operadores:
            n2 = float(pila.get())
            n1 = float(pila.get())
            pila.put(aplicar_operacion(i,n1,n2))
        else:
            pila.put(i)
    return pila.get()

# expresion = "3 4 + 5 * 2 -"
# resultado = evaluar_expresion(expresion)
# print(resultado) # Deber´ıa devolver 33

# EJERCICIO 7
def intercalar_pilas(p1: Pila, p2: Pila) -> Pila:
    p1_copia: Pila = Pila()
    p2_copia: Pila = Pila()
    intercalado_reves: Pila = Pila()
    # intercalo los elementos
    while (not p1.empty()) or (not p2.empty()):
        e2 = p2.get()
        intercalado_reves.put(e2)
        p2_copia.put(e2)
        e1 = p1.get()
        intercalado_reves.put(e1)
        p1_copia.put(e1)
    # ordeno los elementos:
    intercalado: Pila = Pila()
    while not intercalado_reves.empty():
        intercalado.put(intercalado_reves.get())
    # restauro p1 y p2:
    while not p1_copia.empty():
        p1.put(p1_copia.get())
    while not p2_copia.empty():
        p2.put(p2_copia.get())
    return intercalado

# uno = Pila()
# dos = Pila()
# uno.put(1)
# uno.put(11)
# uno.put(111)
# dos.put(2)
# dos.put(22)
# dos.put(222)
# print(intercalar_pilas(uno,dos).queue)

# EJERCICIO 8
def generar_cola_al_azar(cantidad: int, desde: int, hasta: int) -> Cola:
    c: Cola = Cola(cantidad)
    while not c.full():
        print(c.queue)
        c.put(random.randint(desde, hasta))
    print("DEVUELVE:")
    print(c.queue)
    return c

# EJERCICIO 9
def cant_elementos_cola(c: Cola) -> int:
    c_reves: Cola = Cola()
    cant: int = 0
    while not c.empty():
        e: int = c.get()
        c_reves.put(e) #armo una copia de la cola para poder restaurarla despues (como es una cola, los elementos estaran en orden contrario a la original)
        cant += 1 #voy contando cuantos elementos tomo
    c_copia: Cola = Cola()
    while not c_reves.empty(): #ahora si, armo una copia con los elementos en el orden correcto
        c_copia.put(c_reves.get())
    while not c_copia.empty(): #restauro la cola original
        c.put(c_copia.get())
    return cant

# EJERCICIO 10
def buscar_el_max_cola(c: Cola) -> int:
    c_reves: Cola = Cola()
    max: int = c.get()
    c_reves.put(max)
    while not c.empty():
        e: int = c.get()
        if e > max:
            max = e
        c_reves.put(e)
    c_copia: Cola = Cola()
    while not c_reves.empty():
        c_copia.put(c_reves.get())
    while not c_copia.empty():
        c.put(c_copia.get())
    return max

# EJERCICIO 11
def buscar_nota_minima(c: Cola[tuple[str,int]]) -> tuple[str,int]:
    c_reves: Cola = Cola()
    nota_min: tuple = c.get()
    c_reves.put(nota_min)
    while not c.empty():
        nota: tuple = c.get()
        if nota[1] < nota_min[1]:
            nota_min = nota
        c_reves.put(nota)
    c_copia: Cola = Cola()
    while not c_reves.empty():
        c_copia.put(c_reves.get())
    while not c_copia.empty():
        c.put(c_copia.get())
    return nota_min

# EJERCICIO 12
def intercalar_colas(c1: Cola, c2: Cola) -> Cola:
    c1_reves: Cola = Cola()
    c2_reves: Cola = Cola()
    intercalado: Cola = Cola()
    while (not c1.empty()) or (not c2.empty()):
        e1 = c1.get()
        intercalado.put(e1)
        c1_reves.put(e1)
        e2 = c2.get()
        intercalado.put(e2)
        c2_reves.put(e2)
    c1_copia: Cola = Cola()
    c2_copia: Cola = Cola()
    #restauro c1:
    while not c1_reves.empty():
        c1_copia.put(c1_reves.get())
    while not c1_copia.empty():
        c1.put(c1_copia.get())
    #restauro c2:
    while not c2_reves.empty():
        c2_copia.put(c2_reves.get())
    while not c2_copia.empty():
        c2.put(c2_copia.get())
    return intercalado
    
# EJERCICIO 13.1
def generar_tablero() -> list[int]:
    tablero: list[int] = []
    while len(tablero) < 12:
        n: int = random.randint(0,20)
        if not n in tablero:
            tablero.append(n)
    return tablero

def armar_secuencia_bingo() -> Cola[int]:
    numeros: list[int] = list(range(0,20))
    random.shuffle(numeros)
    bolillero: Cola[int] = Cola()
    while numeros != []:
        bolillero.put(numeros.pop())
    print(bolillero.queue)
    return bolillero

# EJERCICIO 13.2
def jugar_carton_de_bingo(carton: list[int], bolillero: Cola[int]) -> int:
    bol_reves: Cola = Cola()
    cant_jugadas: int = 0
    while (len(carton) > 0) and (not bolillero.empty()):
        sale_num: int = bolillero.get()
        if sale_num in carton:
            quitar_elem(carton, sale_num)
        bol_reves.put(sale_num)
        cant_jugadas += 1
    bol_copia: Cola = Cola()
    while not bol_reves.empty():
        bol_copia.put(bol_reves.get())
    while not bol_copia.empty():
        bolillero.put(bol_copia.get())
    return cant_jugadas

def quitar_elem(s: list, e) -> list:
    i: int = 0
    while i < len(s):
        if s[i] == e:
            s.pop(i)
        i += 1

# bol = armar_secuencia_bingo()
# print(bol.queue)
# c = generar_tablero()
# print(c)
# print(jugar_carton_de_bingo(c, bol))

# EJERCICIO 16
# def agrupar_por_longitud(nombre_archivo: str) -> dict:
#     archivo = open(nombre_archivo, "r")
#     lineas: list = archivo.readlines()

# def listar_palabras(linea: list[str]) -> int:
#     texto: str = ""
#     for i in linea:
#         texto += str(i)
#     texto = texto.strip()
#     palabras: list = []
#     pal_actual: str = ""
#     for i in texto:
#         if 

# listar_palabras("         aaa   bbb   cc d ")

# EJERCICIO 14
def n_pacientes_urgentes(c: Cola[tuple[int, str, str]]) -> int:
    c_reves: Cola = Cola()
    cant_urgentes: int = 0
    while not c.empty():
        paciente: tuple = c.get()
        if 0 < paciente[0] < 4:
            cant_urgentes += 1
        c_reves.put(paciente)
    c_copia: Cola = Cola()
    while not c_reves.empty():
        c_copia.put(c_reves.get())
    while not c_copia.empty():
        c.put(c_copia.get())
    return cant_urgentes

# EJERCICIO 17
def calcular_promedio_por_estudiante(notas: list[tuple[str, float]]) -> dict[str, float]:
    promedios: dict[str, float] = {}
    for i in notas:
        if not (i[0] in promedios.keys()):
            promedios[i[0]] = promedio_alumnos(notas, i[0])
    return promedios

def promedio_alumnos(notas: list[tuple[str, float]], alumno: str) -> float:
    total_notas: float = 0
    cant_notas: float = 0
    for i in notas:
        if i[0] == alumno:
            total_notas += i[1]
            cant_notas += 1
    return total_notas / cant_notas

# testnotas = [("ana",10),("ana",9),("bruno",7),("ana",3),("bruno",9)]
# print(calcular_promedio_por_estudiante(testnotas))

# EJERCICIO 21.1
def contar_lineas(nombre_archivo: str) -> int:
    archivo = open(nombre_archivo, "r")
    lineas: list = archivo.readlines()
    archivo.close()
    return len(lineas)

# EJERCICIO 21.2
#def existe_palabra(palabra: str, nombre_archivo: str) -> bool:

# EJERCICIO 22 - REVISAR!!!!!
# def clonar_sin_comentarios(nombres_archivo: str):
#     archivo = open(nombres_archivo, "r+")
#     lineas: list = archivo.readlines()
#     print(lineas)
#     clon: list = []
#     for i in lineas:
#         if i.strip()[0] != "#":
#             clon.append(i)
#     print(clon)
#     archivo.writelines(clon)
        

# def es_comentario(linea: str) -> bool:
#     # quito espacios:
#     sin_esp: str = ""
#     for i in range(len(linea) - 1):
#         par: str = str(linea[i]) + str(linea[i+1])
#         if par != "\t":
#             sin_esp += str(linea[i])
#     # evaluo si el primer caracter es un #:
#     return sin_esp[0] == "#"

