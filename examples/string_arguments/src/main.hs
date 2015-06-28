{-# LANGUAGE ForeignFunctionInterface #-}

import Data.Word (Word32)
import Foreign.C.String (CString(..), newCString)

foreign import ccall "how_many_characters"
  how_many_characters :: CString -> Word32

main :: IO ()
main = do
  str <- newCString "göes to élevên"
  print (how_many_characters str)
