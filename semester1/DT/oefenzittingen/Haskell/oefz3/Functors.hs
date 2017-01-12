
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
  fmap f (Identity a) = Identity (f a)

instance Functor (Pair a) where
  fmap f (Pair a b) = Pair a (f b) 

instance Functor Unit where
  fmap f _ = Unit

