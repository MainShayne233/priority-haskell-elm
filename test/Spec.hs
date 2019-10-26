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
    describe "GET /priorities" $ do
        it "responds with 200" $ do
            get "/priorities" `shouldRespondWith` 200
        it "responds with a list of priorities" $ do
            let users = "[{\"id\":1,\"name\":\"Chores\",\"priorityLevel\":5},{\"id\":2,\"name\":\"Job Search\",\"priorityLevel\":7}]"
            get "/priorities" `shouldRespondWith` users
