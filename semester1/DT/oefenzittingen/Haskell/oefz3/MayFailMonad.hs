
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
  fmap = error "Not implemented"

instance Applicative (MayFail e) where
  pure  = return
  (<*>) = ap

instance Monad (MayFail e) where
  return = error "Not implemented"
  (>>=)  = error "Not implemented"

data Exp = Lit Int | Add Exp Exp | Mul Exp Exp | Div Exp Exp
  deriving (Eq, Ord, Show)

eval :: Exp -> MayFail String Int
eval = error "Not implemented"

evalDo :: Exp -> MayFail String Int
evalDo = error "Not implemented"

