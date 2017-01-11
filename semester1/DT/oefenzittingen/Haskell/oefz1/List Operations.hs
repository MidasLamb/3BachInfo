myAnd :: [Bool] -> Bool
myAnd list 
    | null (tail list) = head list
    | otherwise = head list && myAnd (tail list)
    
myAnd2 [] = True
myAnd2 list = head list && myAnd2 (tail list)
    
myOr :: [Bool] -> Bool    
myOr list 
    | null (tail list) = head list
    | otherwise = head list || myOr (tail list)
    
myOr2 [] = False
myOr2 list = head list || myOr2 (tail list)


append :: [Int] -> [Int] -> [Int]
append list1 list2 =
    list1 ++ list2
    

myProduct :: [Integer] -> Integer
myProduct [] = 1
myProduct (x:xs) = x * myProduct xs


insert :: Int -> [Int] -> [Int]
insert number (x:xs)
    | number <= x = number : (x:xs)
    | otherwise = x : insert number xs
    


myLast :: [Int] -> Int
myLast [x] = x
myLast (x:xs) = myLast xs