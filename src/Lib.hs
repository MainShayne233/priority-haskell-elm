{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Lib
    ( startApp
    , app
    ) where

import Data.Proxy
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

type API = Get '[JSON] String

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = helloWorld

  where helloWorld :: Handler String
        helloWorld = return "Hello, World!"
