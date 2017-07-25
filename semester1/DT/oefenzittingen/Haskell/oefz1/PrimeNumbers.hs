
module PrimeNumbers where

-- * Exercise 5: Prime Numbers
-- ----------------------------------------------------------------------------

sieve :: Int -> [Int]
sieve m = eliminate [2..m]


eliminate :: [Int] -> [Int]
eliminate [] = []

eliminate (x:xs) = x : eliminate (removeMultiples x xs)
    
    
removeMultiples :: Int -> [Int] -> [Int]
removeMultiples n [] = []
removeMultiples n (x:xs)
  | x `mod` n == 0 = removeMultiples n xs
  | otherwise = x : removeMultiples n xs
  
-- Andere oplossing met list comprehension
sieve :: Int -> [Int]
sieve n = removeMultiples [2..n]

removeMultiples :: [Int] -> [Int]
removeMultiples [] = []
removeMultiples (x: xs) = x : removeMultiples [ a | a <- xs, mod a x /= 0]

-- -------------------------
-- Some useful functions
-- -------------------------
sqrtMono :: Double -> Double
sqrtMono = sqrt

i2d :: Int -> Double
i2d = fromIntegral

floorMono :: Double -> Int
floorMono = floor
-- -------------------------

floorSquare :: Int -> Int
floorSquare n = floorMono (sqrtMono (i2d n))

fastSieve :: Int -> [Int]
fastSieve n = fastEliminate n [2..n]

fastEliminate :: Int -> [Int] -> [Int]
fastEliminate m [] = []
fastEliminate m (x:xs)
  | x > floorSquare m = (x:xs)
  | otherwise = x : fastEliminate m (removeMultiples x xs)
