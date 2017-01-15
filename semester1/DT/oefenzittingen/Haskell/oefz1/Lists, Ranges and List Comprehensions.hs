
module Template where

-- * List Operations
-- ----------------------------------------------------------------------------

factorial :: Integer -> Integer

factorial 0 = 1

factorial n 
    | n == 0 = 1
    | n > 0 = factorial (n-1) * n
    
-- oplossing met range
factorial n = product [1..n]

--------------------------------------------------------
sumInts :: Int -> Int -> Int

sumInts low high
    | low > high = 0
    | otherwise = sum [low .. high]
    
-- oplossing met range
sumInts low high = sum [low..high]

--------------------------------------------------------
myRepeat :: Int -> Int -> [Int]

myRepeat n x
    | n <= 0 = []
    | otherwise = [x] ++ (myRepeat (n-1) (x))
    
-- oplossing met range
myRepeat n x = take n [x,x..]

-- oplossing met list comprehension
myRepeat n x = [x | k <- [1..n]]

---------------------------------------------------------
flatten :: [[Int]] -> [Int]

flatten [] = []

flatten (x : xs) = (x) ++ (flatten xs)

-- oplossing met list comprehension
flatten list = [x | xs <- list, x <- xs]

---------------------------------------------------------
range :: Int -> Int -> [Int]

range low high = [low..high]

---------------------------------------------------------
removeMultiples :: Int -> [Int] -> [Int]

removeMultiples x [] = [] 

removeMultiples x (y:ys) 
    | mod y x == 0 = removeMultiples x ys
    | otherwise = [y] ++ removeMultiples x ys
    
-- oplossing met list comprehension
removeMultiples n list = [a | a <- list, not(mod a n == 0)]
