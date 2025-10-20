{-
  Minigrep in Haskell
-}

import System.Environment (getArgs)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [query, filename] -> grep query filename
    _ -> do
      hPutStrLn stderr "Usage: minigrep <query> <filename>"
      exitFailure

grep :: String -> FilePath -> IO ()
grep query filename = do
  contents <- readFile filename
  let
    numberedLines = zip [1 ..] (lines contents)
    matches = [(n, line) | (n, line) <- numberedLines, query `isSubstringOf` line]

  if null matches
    then putStrLn $ "No matches found for '" ++ query ++ "' in " ++ filename
    else mapM_ printMatch matches
 where
  printMatch :: (Int, String) -> IO ()
  printMatch (lineNum, line) =
    putStrLn $ show lineNum ++ ": " ++ line

isSubstringOf :: (Eq a) => [a] -> [a] -> Bool
isSubstringOf [] _ = True
isSubstringOf _ [] = False
isSubstringOf needle haystack = any (needle `isPrefixOf`) (tails haystack)
  where
    tails [] = [[]]
    tails xs@(_ : ys) = xs : tails ys

    isPrefixOf [] _ = True
    isPrefixOf _ [] = False
    isPrefixOf (x : xs) (y : ys) = x == y && xs `isPrefixOf` ys
