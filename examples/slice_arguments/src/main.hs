{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign (Ptr)
import Foreign.C.Types (CUInt(..))
import Foreign.Marshal.Array (withArrayLen)

foreign import ccall "sum_of_even"
  sum_of_even :: Ptr CUInt -> CUInt -> CUInt

main :: IO ()
main = withArrayLen [1,2,3,4,5,6] $ \len arr ->
    print (sum_of_even arr (fromIntegral len))
