
module ApproximatingPi where

-- * Approximating Pi
-- ----------------------------------------------------------------------------

sumf :: [Float] -> Float
sumf [] = 0.0
sumf (x:xs) = x + sumf xs

productf :: [Float] -> Float
productf [] = 1.0
productf (x:xs) = x * productf xs

piSum :: Float -> Float
piSum n = 8 * sumf [1/((4*k+1)*(4*k+3)) | k<-[0..n]]

piProd :: Float -> Float
piProd n = 4 * productf [((2*k + 2) * (2*k + 4))/((2*k + 3)^2) | k<-[0..n]]

