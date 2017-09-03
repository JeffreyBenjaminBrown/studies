module One where -- == Using a single monad transformer

import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Maybe (MaybeT(..))


readUserName, readEmailAddress :: MaybeT IO String
readEmailAddress = readUserName
readUserName = MaybeT $ do
  -- This do loop would be an IO (Maybe String)
  -- MaybeT just wraps it; the do loop is still an IO (Maybe String).
  str <- getLine
  if length str > 5 then return $ Just str
                    else return Nothing

ask :: MaybeT IO (String, String)
ask = do usr <- readUserName -- ** (referred to below)
         email <- readEmailAddress
         -- In the MaybeT monad, unwrapping a {MaybeT f} means unwrapping f.
         -- How could we deduce that from the definition of Maybe T?
         return (usr, email)

login :: String -> String -> IO ()
login a b = putStrLn $ "Hello " ++ a ++ ", your email is " ++ b ++ "."

oneTransformer :: IO ()
oneTransformer = do ask <- runMaybeT ask
  -- whereas one MaybeT do loop can run another one directly (see ** above)
  -- this IO do loop needs to use runMaybeT to run a MaybeT
                    case ask of Nothing -> print "Couldn't login!"
                                Just (u, e) -> login u e
