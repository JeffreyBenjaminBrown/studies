module FromList_T where

import ListT
import Control.Monad.Trans.Class (lift)

myTest :: Int -> ListT IO (Int, Int) -- from "ListT done right"
  -- https://wiki.haskell.org/ListT_done_right
myTest n = do
  let squares = lift . takeWhile (<=n) $ map (^(2::Int)) [0..]
  x <- squares
  y <- squares
  lift $ print (x,y)
  guard $ x + y == n
  lift $ putStrLn "Sum of squares."
  return (x,y)
