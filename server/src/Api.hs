{-# LANGUAGE DataKinds       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators   #-}
module Api
where

import           Data.Proxy
import           Servant
import qualified Elm.Derive

data Priority = Priority {
  id :: Int,
  name :: String,
  priorityLevel :: Int
} deriving (Eq, Show)

type API = "priorities" :> Get '[JSON] [Priority]


api :: Proxy API
api = Proxy

Elm.Derive.deriveBoth Elm.Derive.defaultOptions ''Priority
