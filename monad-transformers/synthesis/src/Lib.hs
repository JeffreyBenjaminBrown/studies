module Lib where

import Control.Monad.Trans.State
import Control.Monad.Trans.Either

type Err = String
type Env = Int

test :: StateT Env (Either Err) Int
test = StateT $ \s -> if s >= 0 then Right (s,s) else Left "Negative."

-- If I read https://wiki.haskell.org/All_About_Monads#Monad_transformers
-- correctly, my intuition (below) stacks the monads backwards
--maybeBork :: EitherT Err (State Env) Int
--maybeBork = EitherT $ do -- StateT :: (s -> m (a, s)) -> StateT s m a
--  x <- get
--  if x < 0 then state $ Left "Negative"
--    else do put $ x + 1
--            return 31

fTotal :: Int -> Int
fTotal = (+1)

low :: [Int]
low = fmap fTotal [1..4]

fPartial :: Int -> Either String Int
fPartial x | x < 0 = Left "Does not handle negative numbers."
           | otherwise = Right $ x + 1

high :: EitherT String [] Int
high = EitherT $ map fPartial [-1..4]
