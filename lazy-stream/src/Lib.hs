module Lib where

theFile = "sample-data/two-words.txt"

crazyFailure = do
  contents <- readFile theFile
  writeFile theFile ('a':contents)

