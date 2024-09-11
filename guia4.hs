-- 20240909: 1, 2, 7, 3, 4



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

-- EJERCICIO 7
-- precond: n >= 0 && 1 <= i <= cantDigitos(n)
iesimoDigito :: Integer -> Integer -> Integer
iesimoDigito n 1 = div n (10 ^ (cantidadDigitos n - 1))
iesimoDigito n i = iesimoDigito sacarPrimero (i-1)
    where sacarPrimero = mod n (10 ^ (cantidadDigitos n - 1))


cantidadDigitos :: Integer -> Integer
cantidadDigitos n
    | n < 10 = 1
    | otherwise = cantidadDigitos (div n 10) + 1

-- EJERCICIO 9
-- precond: n >=0
{--
esCapicua :: Integer -> Bool
esCapicua n
    | cantidadDigitos n == 1 = True
    | 
--}