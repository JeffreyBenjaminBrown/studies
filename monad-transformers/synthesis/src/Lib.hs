module Lib where

import Control.Monad.Trans.State
import Control.Monad.Trans.Either
import Data.List (mapAccumL)

-- mapM :: Monad m => (a -> m b) -> t a -> m (t b)

f :: Int -> State Int ()
f i = modify (+i)

go :: Int
go = snd $ runState (mapM_ f [1..4]) 0
