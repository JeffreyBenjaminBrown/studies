{-# LANGUAGE FlexibleContexts #-}
module MTComposition where

import Control.Monad.Writer
import MaybeT

okay :: MonadWriter [String] m => m Int
okay = do
  tell ["about to succeed"]
  return 3

problem :: MonadWriter [String] m => m ()
problem = do
  tell ["about to fail"]
  fail "oops"

-- newtype WriterT w (m :: * -> *) a = WriterT {runWriterT :: m (a, w)}
-- newtype MaybeT (m :: * -> *) a = MaybeT {runMaybeT :: m (Maybe a)}

aOkay :: WriterT [String] Maybe Int
aOkay = okay

bOkay :: MaybeT (Writer [String]) Int
bOkay = okay

aProb :: WriterT [String] Maybe ()
aProb = problem

bProb :: MaybeT (Writer [String]) ()
bProb = problem
