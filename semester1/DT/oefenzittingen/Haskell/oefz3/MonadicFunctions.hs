
module Template where

import Control.Applicative -- backwards compatibility
import Control.Monad

-- * Implementation of Monadic Functions
-- ----------------------------------------------------------------------------

mySequence :: Monad m => [m a] -> m [a]
mySequence = error "Not implemented"

myMapM :: Monad m => (a -> m b) -> [a] -> m [b]
myMapM = error "Not implemented"

myZipWithM :: Monad m => (a -> b -> m c) -> [a] -> [b] -> m [c]
myZipWithM = error "Not implemented"

myReplicateM :: Monad m => Int -> m a -> m [a]
myReplicateM = error "Not implemented"

