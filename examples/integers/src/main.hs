{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign.C.Types (CUInt(..))

foreign import ccall "addition" addition :: CUInt -> CUInt -> CUInt

main :: IO ()
main = print (addition 1 2)
