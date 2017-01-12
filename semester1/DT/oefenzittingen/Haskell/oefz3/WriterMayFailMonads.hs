
module Template where

import Control.Applicative -- backwards compatibility
import Control.Monad

-- * Writer and MayFail Monads
-- ----------------------------------------------------------------------------

data Log e a = LogError e | LogResult a String
  deriving (Eq, Ord, Show)

instance Functor (Log e) where
  fmap = error "Not implemented"

instance Applicative (Log e) where
  pure  = return
  (<*>) = ap

instance Monad (Log e) where
  return = error "Not implemented"
  (>>=)  = error "Not implemented"

traceLog :: String -> Log e ()
traceLog = error "Not implemented"

safeDivLog :: Int -> Int -> Log String Int
safeDivLog = error "Not implemented"

data Exp = Lit Int | Add Exp Exp | Mul Exp Exp | Div Exp Exp
  deriving (Eq, Ord, Show)

evalLog :: Exp -> Log String Int
evalLog = error "Not implemented"

