
module Template where

-- * Infinite Lists
-- ----------------------------------------------------------------------------

odds :: [Int]
odds = [e | e <- [0..],odd e]

pythagorean :: [(Int, Int, Int)]
pythagorean = [(a,b,c) | b <- [1..], a <- [1..b], c <- [0..(a^2 + b^2)], a^2 + b^2 == c^2]

partialSums :: Num a => [a] -> [a]
partialSums [x] = [x]
partialSums (x:y:xs) = x : (partialSums $ (x+y) : xs)

moessner :: Int -> [Int]
moessner n = helper n [1..]

helper 1 list = list
helper n list = helper (n-1) (partial) 
        where
            newlist = [list !! x | x <- [0..], (mod (x+1) n) /= 0]
            partial = partialSums newlist
