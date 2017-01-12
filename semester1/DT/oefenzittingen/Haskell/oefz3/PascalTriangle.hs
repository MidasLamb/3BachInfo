
module Template where

-- * Pascal's Triangle
-- ----------------------------------------------------------------------------

row :: [Integer] -> [Integer]

row prev = [1] ++ new ++ [1]
    where
        new = [prev !! i + prev !! (i-1) | i <- [1..length prev -1]]



pascal :: [[Integer]]
pascal = [1] : [row l | l <- pascal]

bincoeff :: Int -> Int -> Integer
bincoeff x y = (pascal !! x) !! y

