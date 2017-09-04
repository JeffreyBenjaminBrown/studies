module Order where

import Control.Monad.Trans.State
import Control.Monad.Trans.Either

-- newtype StateT s (m :: * -> *) a = StateT {runStateT :: s -> m (a, s)}
-- so (when "run") this returns an Either
likeAnEither :: StateT Int (Either String) Int
likeAnEither = StateT $ \s -> if s >= 0
  then Right (s,s) else Left "Negative."

-- newtype EitherT e (m :: * -> *) a = EitherT {runEitherT :: m (Either e a)}
-- so (when "run") this returns a State
likeAState :: EitherT String (State Int) Int
likeAState = EitherT $ state $ \s -> if s >= 0
  then (Right s,s) else (Left "Negative.",s)
