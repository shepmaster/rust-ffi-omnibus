{-# LANGUAGE ForeignFunctionInterface #-}

import Data.Word (Word32)
import Foreign.Ptr
import Foreign.ForeignPtr
import Foreign.C.String (CString(..), newCString)

data ZipCodeDatabase

foreign import ccall unsafe "zip_code_database_new"
  zip_code_database_new :: IO (Ptr ZipCodeDatabase)

foreign import ccall unsafe "&zip_code_database_free"
  zip_code_database_free :: FunPtr (Ptr ZipCodeDatabase -> IO ())

foreign import ccall unsafe "zip_code_database_populate"
  zip_code_database_populate :: Ptr ZipCodeDatabase -> IO ()

foreign import ccall unsafe "zip_code_database_population_of"
  zip_code_database_population_of :: Ptr ZipCodeDatabase -> CString -> Word32

createDatabase :: IO (Maybe (ForeignPtr ZipCodeDatabase))
createDatabase = do
  ptr <- zip_code_database_new
  if ptr /= nullPtr
    then do
      foreignPtr <- newForeignPtr zip_code_database_free ptr
      return $ Just foreignPtr
    else
      return Nothing

populate = zip_code_database_populate

populationOf :: Ptr ZipCodeDatabase -> String -> IO (Word32)
populationOf db zip = do
  zip_str <- newCString zip
  return $ zip_code_database_population_of db zip_str

main :: IO ()
main = do
  db <- createDatabase
  case db of
    Nothing -> putStrLn "Unable to create database"
    Just ptr -> withForeignPtr ptr $ \database -> do
        populate database
        pop1 <- populationOf database "90210"
        pop2 <- populationOf database "20500"
        print (pop1 - pop2)
