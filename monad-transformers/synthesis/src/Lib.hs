module Lib where

import Control.Monad.Trans.State
import Control.Monad.Trans.Either

type Err = String
type Env = Int

-- newtype StateT s (m :: * -> *) a = StateT {runStateT :: s -> m (a, s)}
-- so this returns an Either
eitherInside :: StateT Env (Either Err) Int
eitherInside = StateT $ \s -> if s >= 0
  then Right (s,s) else Left "Negative."

-- newtype EitherT e (m :: * -> *) a = EitherT {runEitherT :: m (Either e a)}
-- so this returns a State
stateInside :: EitherT Err (State Env) Int
stateInside = EitherT $ state $ \s -> if s >= 0
  then (Right s,s) else (Left "Negative.",s)
