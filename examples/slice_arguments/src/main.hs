{-# LANGUAGE ForeignFunctionInterface #-}

import Data.Word (Word32)
import Foreign (Ptr)
import Foreign.Marshal.Array (withArrayLen)

foreign import ccall "sum_of_even"
  sum_of_even :: Ptr Word32 -> Word32 -> Word32

main :: IO ()
main = withArrayLen [1,2,3,4,5,6] $ \len arr ->
    print (sum_of_even arr (fromIntegral len))
