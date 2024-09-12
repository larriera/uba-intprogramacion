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