
module Template where

-- * List Operations
-- ----------------------------------------------------------------------------

factorial :: Integer -> Integer

factorial 0 = 1

factorial n 
    | n == 0 = 1
    | n > 0 = factorial (n-1) * n


sumInts :: Int -> Int -> Int

sumInts low high
    | low > high = 0
    | otherwise = sum [low .. high]

myRepeat :: Int -> Int -> [Int]

myRepeat n x
    | n <= 0 = []
    | otherwise = [x] ++ (myRepeat (n-1) (x))

flatten :: [[Int]] -> [Int]

flatten [] = []

flatten (x : xs) = (x) ++ (flatten xs)

range :: Int -> Int -> [Int]

range low high 
    | low > high = []
    | otherwise = [low..high]

removeMultiples :: Int -> [Int] -> [Int]

removeMultiples x [] = [] 

removeMultiples x (y:ys) 
    | mod y x == 0 = removeMultiples x ys
    | otherwise = [y] ++ removeMultiples x ys

