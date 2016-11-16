
data Move = Rock | Scissor | Paper
  deriving (Eq, Show)

beat :: Move -> Move
beat mv
    | mv == Rock = Paper
    | mv == Scissor = Rock
    | mv == Paper = Scissor

lose :: Move -> Move

lose mv
    | mv == Rock = Scissor
    | mv == Scissor = Paper
    | mv == Paper = Rock


data Result = Win | Lose | Draw
  deriving (Eq, Show)

outcome :: Move -> Move -> Result

outcome x y
    | x == beat y = Win
    | x == y = Draw
    | x == lose y = Lose

