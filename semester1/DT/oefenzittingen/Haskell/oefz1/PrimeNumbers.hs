
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
