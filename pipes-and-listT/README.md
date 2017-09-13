Based on the type signature

  runListT :: Monad m => ListT m a -> m ()

it appears to be fundamentally about IO, which is not what I want. What I want is:

  runListT :: Monad m => ListT m a -> m [a]
