module FromPipes where

import Pipes

pair :: ListT IO (Int, Int) -- from Pipes.Tutorial
pair = do
  x <- Select $ each [1, 2]
  lift $ putStrLn $ "x = " ++ show x
  y <- Select $ each [3, 4]
  lift $ putStrLn $ "y = " ++ show y
  return (x, y)

listInEither :: ListT (Either ()) Int
listInEither = do x <- Select $ each [1, 2]
                  return x
