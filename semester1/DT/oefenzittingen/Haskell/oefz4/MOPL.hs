module MOPL where

--Exercise 1
data Statement = Ass String Term | Print Term
data Term = V String | I Int | A (Int -> Int -> Int) Term Term

--Exercise 2
assign :: String -> Term -> Statement
assign = Ass

printTerm :: Term -> Statement
printTerm = Print

intTerm :: Int -> Term
intTerm = I

varTerm :: String -> Term 
varTerm = V

plus :: Term -> Term -> Term
plus = A (+)

times :: Term -> Term -> Term
times = A (*)

minus :: Term -> Term -> Term
minus = A (-)

--Exercise 3
type State = [(String,Int)]

valueOf :: State -> String -> Int
valueOf s x = case lookup x s of
                    Just r -> r

insertS :: String -> Int -> State -> State
insertS var val [] = [(var,val)]
insertS var val ((a,b):r)
    | var == a  = (a,val) : r
    | otherwise = (:) (a,b) (insertS var val r)  

--Exercise 4
evalTerm :: State -> Term -> Int 
evalTerm s t
    |V x <- t = valueOf s x
    |I x <- t = x
    |A f x y <- t = f (evalTerm s x) (evalTerm s y)

--Exercise 5
execAssign :: String -> Term -> State -> State
execAssign var term state = insertS var (evalTerm state term) state 

--Exercise 6
type Program = [Statement]

execPure :: State -> Program -> State
execPure state [] = state
execPure state (p:ps)
    |Ass s t <- p   = execPure (execAssign s t state) ps
    |otherwise      = execPure state ps

--Exercise 7

execute :: Program -> IO ()
execute p = sequence_ $ helper p []

helper :: Program -> State -> [IO()]
helper [] state = [return ()]
helper (p:ps) state 
    |Ass s t <- p   = helper ps (execAssign s t state)
    |Print t <- p   = print (evalTerm state t) : helper ps state
