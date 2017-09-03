-- The last function here is straight from the tutorial.
-- The others are based on it, modified to use a type signature like the last one.
-- It still doesn't work.

module Two where -- == Stacking two monad transformers

import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Maybe (MaybeT(..))
import Control.Monad.Trans.Reader (ReaderT(..))


type Env = (Maybe String, Maybe String)

--readUserName, readEmailAddress :: MaybeT (ReaderT Env IO) String
--readEmailAddress = readUserName
--readUserName = MaybeT $ ReaderT $ do
--  str <- getLine
--  if length str > 5 then return $ Just str
--                    else return Nothing
--
--ask :: MaybeT (ReaderT Env IO) (String, String)
--ask = do usr <- readUserName -- ** (referred to below)
--         email <- readEmailAddress
--         return (usr, email)
--
--login :: String -> String -> IO ()
--login a b = putStrLn $ "Hello " ++ a ++ ", your email is " ++ b ++ "."
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
