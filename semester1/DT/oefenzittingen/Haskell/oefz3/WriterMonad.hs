
module Template where

import Control.Applicative -- backwards compatibility
import Control.Monad

-- * Writer Monad
-- ----------------------------------------------------------------------------

data Exp = Lit Int | Add Exp Exp | Mul Exp Exp
  deriving (Eq, Ord, Show)

evalTrace :: Exp -> (Int, String)
evalTrace = error "Not implemented"

data Writer a = Writer a String
  deriving (Eq, Ord, Show)

instance Functor Writer where
  fmap = error "Not implemented"

instance Applicative Writer where
  pure  = return
  (<*>) = ap

instance Monad Writer where
  return = error "Not implemented"
  (>>=)  = error "Not implemented"

trace :: String -> Writer ()
trace = error "Not implemented"

evalTraceM :: Exp -> Writer Int
evalTraceM = error "Not implemented"

