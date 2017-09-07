module Lib where

import GHC.Conc.Sync (pseq)
import System.IO

theFile = "sample-data/two-words.txt"

crazyFailure = do
  contents <- readFile theFile
  writeFile theFile ('a':contents)

withSeq = do -- this doesn't even crash, just replaces the file with 'a'
  contents <- readFile theFile
  seq contents (return ())
  writeFile theFile ('a':contents)

withPseq = do
  contents <- readFile theFile
  pseq contents (writeFile theFile $ 'a':contents)

withWithFile :: IO ()
withWithFile = do
  putStrLn "about to do reading"
  contents <- withFile theFile ReadMode hGetContents
    -- at this point withFile has closed the file
    -- but hGetContents never read it, because nothing asked for that
  putStrLn "about to seq"
  seq contents (return ())
  putStrLn "about to do writing"
  withFile theFile WriteMode (flip hPutStr $ 'a':contents)
  putStrLn "done writing"

forceEvalInWithFile :: IO ()
forceEvalInWithFile = do
  contents <- withFile theFile ReadMode strictRead
  withFile theFile WriteMode (flip hPutStr ('a':contents))
  where
    strictRead handle = do
      str <- hGetContents handle
      seq str (return str)

hackyButWorks = do
  contents <- readFile theFile
  putStrLn contents
  writeFile theFile ('a':contents)

isThisReallyTheBestSolution = do
  contents <- readFile theFile
  seq (length contents) (return ()) -- this forces evaluation
  -- print $ show $ length contents  -- so would this
  -- let l = length contents -- but this would not
  writeFile theFile ('a':contents)
