-- 20240909: 1, 2, 7, 3, 4
-- 20240911: 5, 6



-- EJERCICIO 1
-- precond: n >= 0
fibonacci :: Integer -> Integer
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci(n-1) + fibonacci(n-2)

-- EJERCICIO 2
-- precond: n >= 0
parteEntera :: Float -> Integer
parteEntera x
    | x < 1 = 0
    | otherwise = parteEntera(x - 1) + 1
{--
Sea 4,817 => res = 4 pues 4 <= 4,817 > 4+1

Si se que la parte entera de 4.18 es 4 => se que la parte entera de 5.18 es 4+1

pe(2.12) = pe(1.12) + 1 = pe( pe(0.12) + 1) + 1 = pe(0 + 1) + 1 = 1 + 1 = 2
--}

-- EJERCICIO 3
esDivisible :: Integer -> Integer -> Bool
esDivisible n m
    | n == 0 = True
    | n < m = False
    | otherwise = esDivisible (n-m) m

-- EJERCICIO 4
sumaImpares :: Integer -> Integer
sumaImpares n
    | n == 1 = 1
    | otherwise = sumaImpares (n-1) + 2*n - 1

-- EJERCICIO 5
-- precond: n>=0
medioFact :: Integer -> Integer
medioFact n
    | n < 2 = 1
    | otherwise = n * medioFact(n-2)

-- EJERCICIO 6
-- precond: n>0
todosDigitosIguales :: Integer -> Bool
todosDigitosIguales n
    | n == mod n 10 = True
    | mod (div n 10) 10 /= mod n 10 = False
    | otherwise = todosDigitosIguales (div n 10)

-- EJERCICIO 7
-- precond: n >= 0 && 1 <= i <= cantidadDigitos(n)
iesimoDigito :: Integer -> Integer -> Integer
iesimoDigito n 1 = div n (10 ^ (cantidadDigitos n - 1))
iesimoDigito n i = iesimoDigito sacarPrimero (i-1)
    where sacarPrimero = mod n (10 ^ (cantidadDigitos n - 1))

cantidadDigitos :: Integer -> Integer
cantidadDigitos n
    | n < 10 = 1
    | otherwise = cantidadDigitos (div n 10) + 1

-- EJERCICIO 8
-- precond: n>0
sumaDigitos :: Integer -> Integer
sumaDigitos n
    | n < 10 = n
    | otherwise = sumaDigitos (div n 10) + ultimoDigito
    where ultimoDigito = mod n 10

-- EJERCICIO 9
-- precond: n >=0
esCapicua :: Integer -> Bool
esCapicua n
    | n < 10 = True
    | n < 100 = div n 10 == ultimoDigito
    | otherwise = iesimoDigito n 1 == ultimoDigito && esCapicua sacarPrimeroyUltimo --va chequeando esCapicua sacando primero&ultimo, achicando n hasta que es menor a 100 (caso base)
    where ultimoDigito = mod n 10
          sacarPrimeroyUltimo = div (sacarPrimerDigito n) 10

sacarPrimerDigito :: Integer -> Integer
sacarPrimerDigito n = mod n (10 ^ ((cantidadDigitos n) - 1))

-- EJERCICIO 10a
f1 :: Integer -> Integer
f1 0 = 1 -- 2^0 = 1
f1 1 = 3 -- 2^0 + 2^1 = 1 + 2 = 3
f1 n = 2^n + f1 (n-1)

-- EJERCICIO 10b
f2 :: Integer -> Float -> Float
f2 n q
    | n == 1 = q -- q^1 = q
    | otherwise = q^^n + f2 (n-1) q

-- EJERCICIO 10c
f3 :: Integer -> Float -> Float
f3 n q
    | n == 1 = q -- q^1 = q
    | otherwise = q^^(2*n) + f2 ((2*n)-1) q

-- EJERCICIO 10d
f4 :: Integer -> Float -> Float
f4 n q
    | n == 1 = q + q^^2
    | otherwise = f3 n q - f2 n q + q^^n

-- EJERCICIO 11a
eAprox :: Integer -> Float
eAprox 1 = 2 -- 1/0! + 1/1! = 1 + 1 = 2
eAprox n = (1 / fromIntegral (factorial n)) + eAprox (n-1)

factorial :: Integer -> Integer
factorial 0 = 1
factorial 1 = 1
factorial n = n * factorial (n-1)

-- EJERCICIO 11b
e :: Float
e = eAprox 10

-- EJERCICIO 12
raizDe2Aprox :: Integer -> Float
raizDe2Aprox n = sucesionEj12 n - 1

sucesionEj12 :: Integer -> Float
sucesionEj12 1 = 2
sucesionEj12 n = 2 + (1 / sucesionEj12 (n-1))

-- EJERCICIO 13
ej13 :: Integer -> Integer -> Integer
ej13 n m
    | n == 1 = sumaPotenciaQ m n
    | otherwise = sumaPotenciaQ m n + ej13 (n-1) m

sumaPotenciaQ :: Integer -> Integer -> Integer --como f2 pero con enteros
sumaPotenciaQ n q
    | n == 1 = q
    | otherwise = q^n + sumaPotenciaQ (n-1) q

-- EJERCICIO 14
sumaPotencias :: Integer -> Integer -> Integer -> Integer
sumaPotencias _ 0 _ = 0 -- cuando (n-1) == 0, entonces llegó al caso base y termina la recursión
sumaPotencias q n m = sumaTerminoExterno q n m + sumaPotencias q (n-1) m -- va bajando el n hasta llegar a 1

sumaTerminoExterno :: Integer -> Integer -> Integer -> Integer -- esta función es la sumatoria de todos los q^(n+b) tal que 1<=b<=m (n es FIJO)
sumaTerminoExterno _ _ 0 = 0 -- cuando (m-1) == 0, entonces llegó al caso base y termina la recursión
sumaTerminoExterno q n m = q^(n+m) + sumaTerminoExterno q n (m-1) -- q^(n+m) + q^(n+m-1) + ... + q^(n+2) + q^(n+1)

-- EJERCICIO 15
sumaRacionales :: Integer -> Integer -> Float
sumaRacionales 0 _ = 0
sumaRacionales n m = sumaRacionalesExt n m + sumaRacionales (n-1) m

sumaRacionalesExt :: Integer -> Integer -> Float --sumatoria de todos los n/b tal que 1<=b<=m (n fijo)
sumaRacionalesExt _ 0 = 0
sumaRacionalesExt n m = fromIntegral n / fromIntegral m + sumaRacionalesExt n (m-1)

-- EJERCICIO 16a
-- precond: n>1
menorDivisor :: Integer -> Integer
menorDivisor n = menorDivisorDesde2 n 2

menorDivisorDesde2 :: Integer -> Integer -> Integer
menorDivisorDesde2 n k
    | mod n k == 0 = k -- si n dividido k da resto 0, entonces k es divisor
    | otherwise = menorDivisorDesde2 n (k+1) -- va probando con k, k+1, ..., n (y ahi siempre termina pues mod n n == 0)

-- EJERCICIO 16b
esPrimo :: Integer -> Bool
esPrimo n = (menorDivisor n) == n

-- EJERCICIO 16c
sonCoprimos :: Integer -> Integer -> Bool
sonCoprimos n m = maxComunDivisor n m == 1

maxComunDivisor :: Integer -> Integer -> Integer --algoritmo de euclides para calcular mcm
maxComunDivisor n 0 = n
maxComunDivisor n m = maxComunDivisor m (mod n m)

-- EJERCICIO 16d
nEsimoPrimo :: Integer -> Integer
nEsimoPrimo 1 = 2
nEsimoPrimo n = primerPrimo (nEsimoPrimo (n-1) + 1) -- va para atrás hasta llegar al primer número primo (2), y suma +1 para buscar los siguientes hasta llegar al enésimo

primerPrimo :: Integer -> Integer -- n>= 2 - primer primo después de n (inclusivo)
primerPrimo n
    | (esPrimo n == True) = n
    | otherwise = primerPrimo (n+1)

-- EJERCICIO 17
esFibonacci :: Integer -> Bool
esFibonacci 1 = True
esFibonacci n = fibonacciDesde3 n 3

fibonacciDesde3 :: Integer -> Integer -> Bool
fibonacciDesde3 n k
    | (fibonacci k) == n = True
    | (fibonacci k) > n = False
    | otherwise = fibonacciDesde3 n (k+1)