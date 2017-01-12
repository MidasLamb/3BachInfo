
module Template where

import Control.Applicative -- backwards compatibility
import Control.Monad

-- * Implementation of Monadic Functions
-- ----------------------------------------------------------------------------

mySequence :: Monad m => [m a] -> m [a]
mySequence (l:ls) = do  
                        x <- l
                        xs <- mySequence ls
                        return $ x:xs

myMapM :: Monad m => (a -> m b) -> [a] -> m [b]
myMapM f (x:xs) = do
                    y <- f x
                    ys <- myMapM f xs
                    return $ y:ys

myZipWithM :: Monad m => (a -> b -> m c) -> [a] -> [b] -> m [c]
myZipWithM f x y = sequence (zipWith f x y)

myReplicateM :: Monad m => Int -> m a -> m [a]
myReplicateM n i = sequence (replicate n i)
