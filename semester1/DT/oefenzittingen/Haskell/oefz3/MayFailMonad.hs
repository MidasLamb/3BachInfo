
module Template where

import Control.Applicative -- backwards compatibility
import Control.Monad

-- * MayFail Monad
-- ----------------------------------------------------------------------------

data MayFail e a = Error e | Result a
  deriving (Eq, Ord, Show)

safeDiv :: Int -> Int -> MayFail String Int
safeDiv a b | b == 0    = Error "Division by zero"
            | otherwise = Result (div a b)

instance Functor (MayFail e) where
  fmap f (Error e) = Error e
  fmap f (Result a) = Result (f a)

instance Applicative (MayFail e) where
  pure  = return
  (<*>) = ap

instance Monad (MayFail e) where
  return x = Result x
  (>>=) m f  = case m of
                    Result a -> f a
                    Error e  -> Error e

data Exp = Lit Int | Add Exp Exp | Mul Exp Exp | Div Exp Exp
  deriving (Eq, Ord, Show)

eval :: Exp -> MayFail String Int
eval e
    |Lit x <- e = return x
    |Add e1 e2 <- e =   eval e1 >>= \x ->
                        eval e2 >>= \y ->
                        return $ x+y
    |Mul e1 e2 <- e =   eval e1 >>= \x ->
                        eval e2 >>= \y ->
                        return $ x*y
    |Div e1 e2 <- e =   eval e1 >>= \x ->
                        eval e2 >>= \y ->
                        safeDiv x y
                        
evalDo :: Exp -> MayFail String Int
evalDo e 
    |Lit x <- e = return x
    |Add e1 e2 <- e = do
                        x <- eval e1
                        y <- eval e2
                        return $ x + y
    |Mul e1 e2 <- e = do
                        x <- eval e1
                        y <- eval e2
                        return $ x * y
    |Div e1 e2 <- e = do
                        x <- eval e1
                        y <- eval e2
                        if(y == 0)
                            then Error "Division by zero"
                            else return $ div x y

