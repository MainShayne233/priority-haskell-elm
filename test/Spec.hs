import Lib ( someFunc )
import Test.Hspec

main :: IO ()
main =
  hspec $ do
    describe "someFunc" $ do
      it "should return " $ do
        someFunc `shouldBe` "someFunc"
