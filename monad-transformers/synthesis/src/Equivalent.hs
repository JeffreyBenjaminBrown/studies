-- Three equivalent statements of a function.
-- One uses do notation, one the monadic bind, one a convenience function that's already in Control..State

module Equivalent where

import Control.Monad.Trans.State

eq1,eq2,eq3 :: Int -> State Int ()
eq1 i = modify (+i)
eq2 i = get >>= (\s -> put $ s + i) >> return ()
eq3 i = do x <- get
           put $ x + i
           return ()
