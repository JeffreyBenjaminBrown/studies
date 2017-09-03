-- The last function here is straight from the tutorial.
-- The others are based on it, modified to use a type signature like the last one.
-- It still doesn't work.

module Two where -- == Stacking two monad transformers

import Control.Monad.Trans.Class (lift)
import Control.Monad.Trans.Maybe (MaybeT(..))
import Control.Monad.Trans.Reader (ReaderT(..), ask)


type Env = (Maybe String, Maybe String)

readUserName' :: MaybeT (ReaderT Env IO) String
readUserName' = MaybeT $ do
  (maybeOldUser, _) <- ask
  case maybeOldUser of
    Just str -> return $ Just str
    Nothing -> do input <- lift getLine
                  if length input > 5
                    then return (Just input)
                    else return Nothing
