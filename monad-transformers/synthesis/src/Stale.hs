module Stale where

import Control.Monad.Trans.Either

fTotal :: Int -> Int
fTotal = (+1)

low :: [Int]
low = fmap fTotal [1..4]

fPartial :: Int -> Either String Int
fPartial x | x < 0 = Left "Does not handle negative numbers."
           | otherwise = Right $ x + 1

high :: EitherT String [] Int
high = EitherT $ map fPartial [-1..4]
