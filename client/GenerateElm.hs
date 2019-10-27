{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}
module GenerateElm ( main )
where

import           Servant.Elm                              ( DefineElm(DefineElm)
                                                          , Proxy(Proxy)
                                                          , defElmImports
                                                          , defElmOptions
                                                          , generateElmModuleWith
                                                          )
import           Api

main :: IO ()
main = generateElmModuleWith
  defElmOptions
  ["GeneratedApi"]
  defElmImports
  "client/src"
  [DefineElm (Proxy :: Proxy Priority)]
  (Proxy :: Proxy API)
