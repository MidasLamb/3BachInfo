import Data.Char
import Data.List

-- * Caesar Cipher
-- ----------------------------------------------------------------------------

let2int :: Char -> Int
let2int c = ord c - ord 'a'

int2let :: Int -> Char
int2let n = chr (ord 'a' + n)

shift :: Int -> Char -> Char
shift = error "Not implemented"

encode :: Int -> String -> String
encode = error "Not implemented"

table :: [Float]
table = [ 8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0, 6.1, 7.0, 0.2, 0.8, 4.0, 2.4
        , 6.7, 7.5, 1.9, 0.1, 6.0, 6.3, 9.1, 2.8, 1.0, 2.4, 0.2, 2.0, 0.1 ]

percent :: Int -> Int -> Float
percent = error "Not implemented"

freqs :: String -> [Float]
freqs = error "Not implemented"

chisqr :: [Float] -> [Float] -> Float
chisqr = error "Not implemented"

rotate :: Int -> [a] -> [a]
rotate = error "Not implemented"

crack :: String -> String
crack = error "Not implemented"

