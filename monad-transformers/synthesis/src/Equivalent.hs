-- Three equivalent statements of a function.
-- One uses do notation, one the monadic bind, one a convenience function that's already in Control..State

module Equivalent where

import Control.Monad.Trans.State

f,g,h :: Int -> State Int ()
f i = modify (+i)
g i = get >>= (\s -> put $ s + i) >> return ()
h i = do x <- get
         put $ x + i
         return ()
