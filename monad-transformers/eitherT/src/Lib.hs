module Lib where

import Control.Monad.Trans.Either

f :: Int -> Int
f = (+1)

low :: [Int]
low = fmap f [1..4]

