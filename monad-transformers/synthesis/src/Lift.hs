-- demonstrates how to use a layer's convenience functions

module Lift where

import Control.Monad.Trans.State
import Control.Monad.Trans.Either
import Control.Monad.Trans.Class
import Control.Monad

useGet :: EitherT String (State [Int]) Int
useGet = EitherT $ do -- if "state $" preceded "do" here, could not use get
  x <- get
  case x of [] -> state $ const (Left "agh", x)
            a:as ->  state $ const (Right a,as)

useBothLevels :: Int -> StateT Int (Either String) Int
useBothLevels i = do
  x <- get
  y <- case i > 0 of True -> lift $ Right i
                     False -> lift $ Left "doh!"
  return y
