module Main where

import Lib

main :: IO ()
main = do
  putStrLn "Listening on localhost:8080"
  startApp
