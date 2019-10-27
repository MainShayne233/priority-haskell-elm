{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Lib
  ( startApp
  , app
  , apiApp
  )
where

import           Data.Proxy
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Network.Wai.MakeAssets
import           Servant
import           System.IO
import qualified Elm.Derive


import           Api

type WithAssets = API :<|> Raw

withAssets :: Proxy WithAssets
withAssets = Proxy

options :: Network.Wai.MakeAssets.Options
options = Network.Wai.MakeAssets.Options "client"

server :: IO (Server WithAssets)
server = do
  assets <- serveAssets options
  return (apiServer :<|> Tagged assets)

app :: IO Application
app = serve withAssets <$> server

apiApp :: Application
apiApp = serve api apiServer

startApp :: IO ()
startApp = do
  let port     = 8080
      settings = setPort port $ setBeforeMainLoop
        (hPutStrLn stderr ("listening on port " ++ show port ++ "..."))
        defaultSettings
  runSettings settings =<< app


apiServer :: Server API
apiServer = priorities

 where
  priorities :: Handler [Priority]
  priorities = return [Priority 1 "Chores" 5, Priority 2 "Job Search" 7]
