
module ArithmeticExpressions where

-- * Arithmetic Expressions
-- ----------------------------------------------------------------------------

data Exp = Const Int
         | Add Exp Exp
         | Sub Exp Exp
         | Mul Exp Exp
  deriving (Show, Eq)

eval :: Exp -> Int
eval (Const value) = value
eval (Add exp1 exp2) = eval exp1 + eval exp2
eval (Sub exp1 exp2) = eval exp1 - eval exp2
eval (Mul exp1 exp2) = eval exp1 * eval exp2

data Inst = IPush Int | IAdd | ISub | IMul
  deriving (Show, Eq)

type Prog  = [Inst]
type Stack = [Int]

runtimeError :: Stack
runtimeError = error "Runtime error."

execute :: Inst -> Stack -> Stack
execute (IPush value) stack  = value:stack
execute IAdd (val1:val2:tail) = (val1 + val2):tail
execute ISub (val1:val2:tail) = (val2 - val1):tail
execute IMul (val1:val2:tail) = (val1 * val2):tail

run :: Prog -> Stack -> Stack
run [] stack = stack
run (inst:insts) stack = run insts (execute inst stack)

compile :: Exp -> Prog
compile (Const value) = [IPush value]
compile (Add exp1 exp2) = compile exp1 ++ compile exp2 ++ [IAdd]
compile (Sub exp1 exp2) = compile exp1 ++ compile exp2 ++ [ISub]
compile (Mul exp1 exp2) = compile exp1 ++ compile exp2 ++ [IMul]
