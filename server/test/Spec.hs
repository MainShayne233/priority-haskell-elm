{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}
import Lib (apiApp)
import Test.Hspec
import Test.Hspec.Wai


main :: IO ()
main =
  hspec $ do
  with (return apiApp) $ do
    describe "GET /priorities" $ do
        it "responds with 200" $ do
            get "/priorities" `shouldRespondWith` 200
        it "responds with a list of priorities" $ do
            let users = "[{\"id\":1,\"name\":\"Chores\",\"priorityLevel\":5},{\"id\":2,\"name\":\"Job Search\",\"priorityLevel\":7}]"
            get "/priorities" `shouldRespondWith` users
