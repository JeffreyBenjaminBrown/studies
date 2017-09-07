-- The Either monad returns at the first Left.
-- How to get that behavior inside another monad?

module InnerEither where

import Control.Monad.Trans.State
import Control.Monad.Trans.Either
import Control.Monad.Trans.Reader
import Control.Monad.Trans.Class
import Control.Monad

chainOfEithers :: StateT Int (Either String) Int
chainOfEithers = do
  x <- lift $ Right 1
  y <- lift $ Left "this is the last line to execute"
  z <- lift $ Right (False,"imaginary")
  return x

liftedChain :: StateT [Int] (Either String) [Int]
liftedChain = do
  let f i | i < 0 = Left "too low"
          | otherwise = Right i
  y <- lift $ mapM f [-11..4] -- this gives a Left
  z <- lift $ mapM f [1..4]   -- so is this evaluated?
  return z

testLiftedChain :: StateT [Int] (EitherT String IO) [Int]
testLiftedChain = do
  let f i | i < 0 = return $ Left "too low"
          | otherwise = return $ Right i
  x <- lift $ mapM f [1..4]
  lift $ lift $ print "positives evaluated"
  y <- lift $ mapM f [-11..4]
  lift $ lift $ print "negatives evaluated"
  z <- lift $ mapM f [1..4]
  lift $ lift $ print "more positives evaluated"
  return [1]
