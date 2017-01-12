module Template where

import Control.Monad

-- * Drilling on IO
-- ----------------------------------------------------------------------------

prog1 :: IO ()
prog1 = do
            m <- readLn :: IO Int
            n <- readLn :: IO Int
            sequence_ $ replicate n (print m)
            

prog2 :: IO ()
prog2 = do
            line <- getLine
            if(line == "")
                then return ()
                else do
                        print $ reverse line
                        prog2

index :: [IO a] -> IO Int -> IO a
index list num = 
        do
            a <- num
            list !! a
