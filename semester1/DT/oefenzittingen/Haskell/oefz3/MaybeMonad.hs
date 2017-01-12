
module Template where

import Control.Applicative -- backwards compatibility
import Control.Monad

-- * Maybe Monad
-- ----------------------------------------------------------------------------

sumABC :: [(String, Int)] -> Maybe Int
sumABC l = 
    case lookup "A" l of
        Just a  -> case lookup "B" l of
                        Just b  -> case lookup "C" l of
                                        Just c  -> Just (a+b+c)
                                        Nothing -> Nothing
                        Nothing -> Nothing
        Nothing -> Nothing

sumABCBind :: [(String, Int)] -> Maybe Int
sumABCBind l = 
        lookup "A" l >>= \a ->
        lookup "B" l >>= \b ->
        lookup "C" l >>= \c ->
        Just (a+b+c)

sumABCDo :: [(String, Int)] -> Maybe Int
sumABCDo l = do     
                a <- lookup "A" l
                b <- lookup "B" l
                c <- lookup "C" l
                Just (a+b+c)

