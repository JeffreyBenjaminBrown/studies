-- file: ch18/LocalReader.hs

{-# LANGUAGE FlexibleContexts #-}

module LocalReader where

import Control.Monad.Reader

announce :: MonadReader String m => String -> m String
announce condition  = do
  it <- ask
  return (condition ++ ", it is " ++ it)

localExample :: Reader String (String, String, String)
localExample = do
  a <- announce "First"
  b <- local (++"dy") $ announce "Second"
  c <- announce "Third"
  return (a, b, c)

