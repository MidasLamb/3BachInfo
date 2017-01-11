mySum :: [Integer] -> Integer
mySum [] = 0
mySum (x:xs) = x + mySum xs

myProduct :: [Integer] -> Integer
myProduct [] = 1
myProduct (x:xs) = x * myProduct xs

foldInts :: (Integer -> Integer -> Integer) -> Integer -> [Integer] -> Integer
foldInts _ base [] = base
foldInts fn base (x:xs) = fn x (foldInts fn base xs)

myFoldl :: (b -> a -> b) -> b -> [a] -> b
myFoldl fn base [x] = fn base x
myFoldl fn base (x:xs) = myFoldl fn (fn base x) xs

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ base [] = base
myFoldr fn base (x:xs) = fn x (myFoldr fn base xs)

readInBase :: Int -> [Int] -> Int
readInBase base digits = error "Not implemented"

myMap :: (a -> b) -> [a] -> [b]
myMap fn list = [fn x | x <- list]

myMapF :: (a -> b) -> [a] -> [b]
myMapF fn list = foldr (\x y -> (fn x) : y) [] list 

