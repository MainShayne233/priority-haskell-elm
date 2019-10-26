{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Lib
  ( startApp
  , app
  )
where

import           Data.Aeson
import           Data.Aeson.TH
import           Data.Proxy
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant

data Priority = Priority {
  id :: Int,
  name :: String,
  priorityLevel :: Int
} deriving (Eq, Show)

$(deriveJSON defaultOptions ''Priority)

type API = Get '[JSON] String
  :<|> "priorities" :> Get '[JSON] [Priority]

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = helloWorld :<|> priorities

 where
  helloWorld :: Handler String
  helloWorld = return "Hello, World!"

  priorities :: Handler [Priority]
  priorities = return [Priority 1 "Chores" 5, Priority 2 "Job Search" 7]
