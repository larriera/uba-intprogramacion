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
    c_copia: Cola = Cola()
    cant: int = 0
    while not c.empty():
        e: int = c.get()
        c_copia.put(e) #armo una copia de la cola para poder restaurarla despues
        cant += 1 #voy contando cuantos elementos tomo
    while not c_copia.empty(): #restauro la cola original
        c.put(c_copia.get())
    return cant

# EJERCICIO 10
def buscar_el_max_cola(c: Cola) -> int:
    c_copia: Cola = Cola()
    max: int = c.get()
    c_copia.put(max)
    while not c.empty():
        e: int = c.get()
        if e > max:
            max = e
        c_copia.put(e)
    while not c_copia.empty():
        c.put(c_copia.get())
    return max

# EJERCICIO 11
def buscar_nota_minima(c: Cola[tuple[str,int]]) -> tuple[str,int]:
    c_copia: Cola = Cola()
    nota_min: tuple = c.get()
    c_copia.put(nota_min)
    while not c.empty():
        nota: tuple = c.get()
        if nota[1] < nota_min[1]:
            nota_min = nota
        c_copia.put(nota)
    while not c_copia.empty():
        c.put(c_copia.get())
    return nota_min

# EJERCICIO 12
def intercalar_colas(c1: Cola, c2: Cola) -> Cola:
    c1_copia: Cola = Cola()
    c2_copia: Cola = Cola()
    intercalado: Cola = Cola()
    while (not c1.empty()) or (not c2.empty()):
        e1 = c1.get()
        intercalado.put(e1)
        c1_copia.put(e1)
        e2 = c2.get()
        intercalado.put(e2)
        c2_copia.put(e2)
    #restauro c1:
    while not c1_copia.empty():
        c1.put(c1_copia.get())
    #restauro c2:
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
    bol_copia: Cola = Cola()
    cant_jugadas: int = 0
    while (len(carton) > 0) and (not bolillero.empty()):
        sale_num: int = bolillero.get()
        if sale_num in carton:
            quitar_elem(carton, sale_num)
        bol_copia.put(sale_num)
        cant_jugadas += 1
    while not bol_copia.empty():
        bolillero.put(bol_copia.get())
    return cant_jugadas

def quitar_elem(s: list, e) -> list:
    i: int = 0
    while i < len(s):
        if s[i] == e:
            s.pop(i)
        i += 1

# EJERCICIO 14
def n_pacientes_urgentes(c: Cola[tuple[int, str, str]]) -> int:
    c_copia: Cola = Cola()
    cant_urgentes: int = 0
    while not c.empty():
        paciente: tuple = c.get()
        if 0 < paciente[0] < 4:
            cant_urgentes += 1
        c_copia.put(paciente)
    while not c_copia.empty():
        c.put(c_copia.get())
    return cant_urgentes

# EJERCICIO 15
def atencion_a_clientes(c: Cola[tuple[str, int, bool, bool]]) -> Cola[tuple[str, int, bool, bool]]:
    c_copia: Cola = Cola()
    prioridad: Cola = Cola()
    preferencial: Cola = Cola()
    resto: Cola = Cola()
    while not c.empty():
        cliente: tuple = c.get()
        if cliente[3]: #tiene prioridad = True
            prioridad.put(cliente)
        elif cliente[2]: #tiene cuenta preferencial = True
            preferencial.put(cliente)
        else:
            resto.put(cliente)
        c_copia.put(cliente)
    orden_de_atencion: Cola = Cola()
    while not prioridad.empty():
        print(prioridad.queue)
        orden_de_atencion.put(prioridad.get())
    while not preferencial.empty():
        orden_de_atencion.put(preferencial.get())
    while not resto.empty():
        orden_de_atencion.put(resto.get())
    while not c_copia.empty():
        c.put(c_copia.get())
    return orden_de_atencion

# EJERCICIO 16
def agrupar_por_longitud(nombre_archivo: str) -> dict:
    d: dict = {}
    palabras: list = palabras_en_archivo(nombre_archivo)
    for i in palabras:
        l: int = len(i)
        if l in d:
            d[l] += 1
        else:
            d[l] = 1
    if 0 in d:
        d.pop(0)
    return d

def palabras_en_archivo(nombre_archivo: str) -> list[str]:
    archivo = open(nombre_archivo, "r")
    contenido: str = archivo.read()
    archivo.close()
    palabras: list = []
    palabra_actual: str = ""
    for i in contenido:
        if (i == " ") or (i == "\n"):
            palabras.append(palabra_actual)
            palabra_actual = ""
        else:
            palabra_actual += i
    palabras.append(palabra_actual)
    return palabras

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

# EJERCICIO 18
def la_palabra_mas_frecuente(nombre_archivo: str) -> str:
    palabras: list = palabras_en_archivo(nombre_archivo)
    frecuencias: dict = {}
    for i in palabras:
        if i in frecuencias:
            frecuencias[i] += 1
        else:
            frecuencias[i] = 1
    mas_frecuente: list = ("", 0)
    for k in frecuencias:
        if int(frecuencias[k]) > int(mas_frecuente[1]):
            nueva_mas_frecuente: tuple = (k, frecuencias[k])
            mas_frecuente = nueva_mas_frecuente
    return mas_frecuente[0]

# EJERCICIO 19
# historiales: dict = {}
# hist: Pila = Pila()
# hist.put("marea.net.ar")
# hist.put("oasis.net")
# hist.put("google.com")
# historiales["yop"] = hist

def visitar_sitio(historiales: dict[str, Pila[str]], usuario: str, sitio: str):
    if usuario in historiales:
        historiales[usuario].put(sitio)
    else:
        nuevo_historial: Pila = Pila()
        nuevo_historial.put(sitio)
        historiales[usuario] = nuevo_historial

def navegar_atras(historiales: dict[str, Pila[str]], usuario: str):
    mi_historial: Pila = historiales[usuario]
    sitio_actual: str = mi_historial.get()
    sitio_anterior: str = mi_historial.get()
    # muevo el sitio anterior arriba de todo
    mi_historial.put(sitio_actual)
    mi_historial.put(sitio_anterior)
    # actualizo los historiales
    historiales[usuario] = mi_historial

# EJERCICIO 20
# inv: dict = {}
# inv["silla"] = {"precio": 1.1, "cantidad": 4}
# inv["mesa"] = {"precio": 2.2, "cantidad": 3}
# print(inv)

def agregar_producto(inventario: dict[str, dict[str, float | int]], nombre: str, precio: float, cantidad: int):
    info: dict = {}
    info["precio"] = precio
    info["cantidad"] = cantidad
    inventario[nombre] = info

def actualizar_stock(inventario: dict[str, dict[str, float | int]], nombre: str, cantidad: int):
    inventario[nombre]["cantidad"] = cantidad

def actualizar_precios(inventario: dict[str, dict[str, float | int]], nombre: str, precio: float):
    inventario[nombre]["precio"] = precio

def calcular_valor_inventario(inventario: dict[str, dict[str, float | int]]) -> float:
    total: float = 0.0
    for producto in inventario:
        total += inventario[producto]["precio"] * inventario[producto]["cantidad"]
    return total

# Para el ejercicio 21, tomo como "palabra" a cualquier secuencia de caracteres no separados por espacios en blanco
# EJERCICIO 21.1
def contar_lineas(nombre_archivo: str) -> int:
    archivo = open(nombre_archivo, "r")
    lineas: list = archivo.readlines()
    archivo.close()
    return len(lineas)

# EJERCICIO 21.2
def existe_palabra(palabra: str, nombre_archivo: str) -> bool:
    palabras: list = palabras_en_archivo(nombre_archivo)
    return palabra in palabras

# EJERCICIO 21.3
def cantidad_de_apariciones(palabra: str, nombre_archivo: str) -> int:
    palabras: list = palabras_en_archivo(nombre_archivo)
    cant: int = 0
    for i in palabras:
        if i == palabra:
            cant += 1
    return cant

# EJERCICIO 22
def clonar_sin_comentario(nombre_archivo: str):
    archivo = open(nombre_archivo, "r")
    lineas: list = archivo.readlines()
    archivo.close
    lineas_filtradas: list = []
    for i in lineas:
        if es_comentario_valido(i):
            lineas_filtradas.append(i)
    # armo el clon
    partes_nombre: tuple = nombre_y_extension(nombre_archivo)
    nombre_clon: str = partes_nombre[0] + "_sincom." + partes_nombre[1]
    clon = open(nombre_clon, "w")
    for i in lineas_filtradas:
        clon.write(i)
    clon.close()

def es_comentario_valido(linea: str) -> bool:
    valido: bool = True
    no_termine: bool = True
    i: int = 0
    while no_termine and (i < len(linea)):
        if (linea[i] != " ") and (linea[i] != "\t"):
            valido = linea[i] != "#"
            no_termine = False
        i += 1
    return valido

def nombre_y_extension(nombre_archivo: str) -> tuple[str, str]:
    nombre: str = ""
    ext: str = ""
    i: int = 0
    while (nombre_archivo[i] != ".") and (i < len(nombre_archivo)):
        nombre += nombre_archivo[i]
        i += 1
    i += 1
    while (i < len(nombre_archivo)):
        ext += nombre_archivo[i]
        i += 1
    res: tuple = (nombre, ext)
    return res