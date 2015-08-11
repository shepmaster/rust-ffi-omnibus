{-# LANGUAGE ForeignFunctionInterface #-}

import Data.Word (Word8)
import Foreign.Ptr (nullPtr)
import Foreign.C.String (CString(..), peekCString)

foreign import ccall unsafe "theme_song_generate"
  theme_song_generate :: Word8 -> IO (CString)

foreign import ccall unsafe "theme_song_free"
  theme_song_free :: CString -> IO ()

createThemeSong :: Word8 -> IO (Maybe (String))
createThemeSong len = do
  ptr <- theme_song_generate len
  if ptr /= nullPtr
    then do
      str <- peekCString ptr
      theme_song_free ptr
      return $ Just str
    else
      return Nothing

main :: IO ()
main = do
  song <- createThemeSong 5
  case song of
    Nothing -> putStrLn "Unable to create theme song"
    Just str -> putStrLn str
