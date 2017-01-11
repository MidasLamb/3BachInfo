module Template where

-- * Sequences
-- ----------------------------------------------------------------------------

class Sequence a where
  prev :: a -> a
  next :: a -> a

instance Sequence Int where
  prev x = x - 1
  next = (+ 1)

instance Sequence Char where
  prev 'a' = error "no value before 'a'"
  prev x = reverse ['a'..x] !! 1
  next 'z' = error "no value after 'z'"
  next x = [x..'z'] !! 1


instance Sequence Bool where
  prev = not
  next = not

class Sequence a => LeftBoundedSequence a where
  firstElem :: a

class Sequence a => RightBoundedSequence a where
  lastElem :: a

instance LeftBoundedSequence Int where
  firstElem = minBound :: Int

instance LeftBoundedSequence Char where
  firstElem = 'a'

instance LeftBoundedSequence Bool where
  firstElem = minBound :: Bool

instance RightBoundedSequence Int where
  lastElem = maxBound :: Int

instance RightBoundedSequence Char where
  lastElem = 'z'

instance RightBoundedSequence Bool where
  lastElem = maxBound :: Bool


