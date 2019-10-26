{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
import Lib (app)
import Test.Hspec
import Test.Hspec.Wai

main :: IO ()
main =
  hspec $ do
  with (return app) $ do
    describe "GET /" $ do
        it "responds with 200" $ do
          get "/" `shouldRespondWith` 200
        it "responds with Hello, World!" $ do
          get "/" `shouldRespondWith` "\"Hello, World!\""
