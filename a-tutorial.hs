-- Making Sense of Multiple Monads – James Bowen
--  https://medium.com/@james_32022/making-sense-of-multiple-monads-a51aeebd0d4d

import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Maybe (MaybeT(..))
import Control.Monad.Trans.Reader (ReaderT(..))

readUserName, readEmailAddress :: MaybeT IO String
readEmailAddress = readUserName
readUserName = MaybeT $ do
  str <- getLine
  if length str > 5
    then return $ Just str
    else return Nothing

login :: String -> String -> IO ()
login a b = putStrLn $ "Hello " ++ a ++ ", your email is " ++ b ++ "."

oneTransformer :: IO ()
oneTransformer = do
  ask <- runMaybeT $ do
    usr <- readUserName
    email <- readEmailAddress
    return (usr, email)
  case ask of
    Nothing -> print "Couldn't login!"
    Just (u, e) -> login u e

--
--type Env = (Maybe String, Maybe String)
--
--readUserName' :: MaybeT (ReaderT Env IO) String
--readUserName' = MaybeT $ do
--  (maybeOldUser, _) <- ask
--  case maybeOldUser of
--    Just str -> return str
--    Nothing -> do 
--      input <- lift getLine -- lift allows IO from inside ReaderT Env IO
--      if length input > 5
--        then return (Just input)
--        else return Nothing
--
