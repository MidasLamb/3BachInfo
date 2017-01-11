mapLC :: (a -> b) -> [a] -> [b]
mapLC f xs = [f x | x <- xs]

filterLC :: (a -> Bool) -> [a] -> [a]
filterLC f xs = [x | x <- xs, f x]

