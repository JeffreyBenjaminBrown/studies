module UseGet where

import Control.Monad.Trans.State
import Control.Monad.Trans.Either

useGet :: EitherT String (State [Int]) Int
useGet = EitherT $ do -- if "state" preceded "do" here, could not use get
  x <- get
  case x of [] -> state $ const (Left "agh", x)
            a:as ->  state $ const (Right a,as)
