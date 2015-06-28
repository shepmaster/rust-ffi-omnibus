{-# LANGUAGE ForeignFunctionInterface #-}

import Data.Word (Word32)

foreign import ccall "addition"
  addition :: Word32 -> Word32 -> Word32

main :: IO ()
main = print (addition 1 2)
