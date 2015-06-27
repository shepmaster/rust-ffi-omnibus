{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign.C.String (CString(..), newCString)
import Foreign.C.Types (CUInt(..))

foreign import ccall "how_many_characters"
  how_many_characters :: CString -> CUInt

main :: IO ()
main = do
  str <- newCString "göes to élevên"
  print (how_many_characters str)
