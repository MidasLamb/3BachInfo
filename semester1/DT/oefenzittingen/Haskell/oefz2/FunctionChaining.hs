applyAll :: [a -> a] -> a -> a
applyAll [f] v = f v
applyAll (f:fs) v = f $ applyAll fs v

applyTimes :: Int -> (a -> a) -> a -> a
applyTimes n f v
    | n == 0    = v
    | otherwise = applyTimes (n-1) f (f v)

applyMultipleFuncs :: a -> [a -> b] -> [b]
applyMultipleFuncs a fs = [f a | f <- fs]

