module HashTablesPerformance
where

import System.IO
import Data.List
import System.Random
import Control.Monad
import Criterion.Main
import Control.Monad.ST
import Data.Maybe

import qualified Data.Vector as V
import Data.Vector ((!))
import qualified Data.HashMap.Strict as HM

import qualified Data.HashTable.ST.Cuckoo as C
import qualified Data.HashTable.ST.Basic as B
import qualified Data.HashTable.Class as H

type HashTableC s k v = C.HashTable s k v
type HashTableB s k v = B.HashTable s k v

filename        = "large-file.txt"
indexesFilename = "indexes.txt"

writeLargeFile :: Int -> IO ()
writeLargeFile num = do
  withFile filename WriteMode $ \file -> do
    let randomInt = randomIO :: IO Int
        randomInts = take num $ repeat randomInt

    forM_ randomInts $ \r -> do
      r' <- r
      hPutStrLn file (show r')

  withFile indexesFilename WriteMode $ \file -> do
    let randomIndex = randomRIO (0, num) :: IO Int
        max = round ((fromIntegral num) * 0.05) :: Int
        randomIndexes = take max $ repeat randomIndex

    forM_ randomIndexes $ \r -> do
      r' <- r
      hPutStrLn file (show r')


numOf2s    = length . filter (== '2')
allLines   = fmap lines (readFile filename)

getKeys :: [String] -> IO [String]
getKeys contents = do
  indexes <- fmap lines (readFile indexesFilename)
  let vContents = V.fromList contents
      keys = map (\i -> vContents ! (read i)) indexes
  return keys

hashMapWithInsert :: IO [Int]
hashMapWithInsert = do
  contents <- allLines
  keys     <- getKeys contents

  let hm = foldr (\line hm -> HM.insert line (numOf2s line) hm) HM.empty contents
      values = map (\key -> fromJust (HM.lookup key hm)) keys
  return values

hashMapWithUnions :: IO [Int]
hashMapWithUnions = do
  contents <- allLines
  keys     <- getKeys contents

  let hm = foldr (\line hm -> HM.union (HM.singleton line (numOf2s line)) hm) HM.empty contents
      values = map (\key -> fromJust (HM.lookup key hm)) keys

  return values

hashtableCuckoo :: IO [Int]
hashtableCuckoo = do
  contents <- allLines
  keys     <- getKeys contents

  let x = runST $ do h <- H.new :: ST s (HashTableC s String Int)
                     forM_ contents $ \line ->
                       H.insert h line (numOf2s line)

                     forM keys $ \key -> do
                       v <- H.lookup h key
                       return (fromJust v)
  return x

hashtableBasic :: IO [Int]
hashtableBasic = do
  contents <- allLines
  keys     <- getKeys contents

  let x = runST $ do h <- H.new :: ST s (HashTableB s String Int)
                     forM_ contents $ \line ->
                       H.insert h line (numOf2s line)

                     forM keys $ \key -> do
                       v <- H.lookup h key
                       return (fromJust v)
  return x

main :: IO ()
main = defaultMain [
    bench "hashmap inserts" $ nfIO hashMapWithInsert
  , bench "hashmap union" $ nfIO hashMapWithUnions
  , bench "hashtable cuckoo" $ nfIO hashtableCuckoo
  , bench "hashtable basic" $ nfIO hashtableBasic
  ]
