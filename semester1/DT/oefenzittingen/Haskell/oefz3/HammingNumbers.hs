
module Template where

-- * Hamming Numbers
-- ----------------------------------------------------------------------------

merge :: Ord a => [a] -> [a] -> [a]
merge [] list = list
merge list [] = list
merge (x:xs) (y:ys)
    | x < y = x : merge xs (y:ys)
    | x > y = y : merge (x:xs) ys
    | x == y = x : merge xs ys

hamming :: [Integer]
hamming = 1 : (merge [5*i | i <-hamming] $ merge [2*i | i <-hamming] [3*i | i <-hamming])

