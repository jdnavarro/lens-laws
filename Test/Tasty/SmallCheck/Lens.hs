{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}
module Test.Tasty.SmallCheck.Lens where

import Control.Lens
import Test.SmallCheck.Series (Serial(series), CoSerial)
import Test.Tasty (TestTree, testGroup)
import Test.Tasty.SmallCheck (testProperty)

import Test.SmallCheck.Lens
import Test.Tasty.SmallCheck.Traversal

testLens
  :: ( Eq s, Eq a, Show s, Show a
     , Serial IO a, Serial Identity a, CoSerial IO a
     , Serial IO s
     )
  => Lens' s a -> TestTree
testLens l = testGroup "Lens Laws"
  [ testProperty "view l (set l b a) ≡ b" $
      lensSetView l series
  , testProperty "set l (view l a) a ≡ a" $
      lensViewSet l series series
  , testTraversal l
  ]