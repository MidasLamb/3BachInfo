
module Template where

import Control.Applicative -- backwards compatibility
import Control.Monad

-- * Writer Monad
-- ----------------------------------------------------------------------------

data Exp = Lit Int | Add Exp Exp | Mul Exp Exp
  deriving (Eq, Ord, Show)

evalTrace :: Exp -> (Int, String)
evalTrace (Lit x) = (x,"Lit\n")
evalTrace (Add e1 e2) = (x+y,"Add\n" ++ sx ++ sy)
    where
        (x,sx) = evalTrace e1
        (y,sy) = evalTrace e2

evalTrace (Mul e1 e2) = (x*y,"Mul\n" ++ sx ++ sy)
    where
        (x,sx) = evalTrace e1
        (y,sy) = evalTrace e2


data Writer a = Writer a String
  deriving (Eq, Ord, Show)

instance Functor Writer where
  fmap f (Writer a s) = Writer (f a) s

instance Applicative Writer where
  pure  = return
  (<*>) = ap

instance Monad Writer where
  return x = Writer x ""
  Writer x s >>= f = case f x of
    Writer y s' -> Writer y (s ++ s')

trace :: String -> Writer ()
trace s = Writer () s

evalTraceM :: Exp -> Writer Int
evalTraceM (Lit x) = Writer x "Lit\n"
evalTraceM (Add x y) = do
  trace "Add\n"
  vx <- evalTraceM x
  vy <- evalTraceM y
  return (vx + vy)
evalTraceM (Mul x y) = do
  trace "Mul\n"
  vx <- evalTraceM x
  vy <- evalTraceM y
  return (vx * vy)

