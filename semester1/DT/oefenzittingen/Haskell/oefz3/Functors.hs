
module Template where

import Control.Applicative -- backwards compatibility
import Control.Monad

-- * Functors
-- ----------------------------------------------------------------------------

data Identity a = Identity a
  deriving (Eq, Ord, Show)

data Pair a b = Pair a b
  deriving (Eq, Ord, Show)

data Unit a = Unit

instance Eq (Unit a) where
  Unit == Unit = True

instance Show (Unit a) where
  show Unit = "Unit"

instance Functor Identity where
  fmap = error "Not implemented"

instance Functor (Pair a) where
  fmap = error "Not implemented"

instance Functor Unit where
  fmap = error "Not implemented"

