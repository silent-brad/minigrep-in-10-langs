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
    -- matchingLines = filter (query `isSubsequenceOf`) (lines contents)
    numberedLines = zip [1 ..] (lines contents)
    matches = [(n, line) | (n, line) <- numberedLines, query `isSubsequenceOf` line]

  if null matches
    then putStrLn $ "No matches found for '" ++ query ++ "' in " ++ filename
    else mapM_ printMatch matches
 where
  printMatch :: (Int, String) -> IO ()
  printMatch (lineNum, line) =
    putStrLn $ show lineNum ++ ": " ++ line

isSubsequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf needle@(x : xs) (y : ys)
  | x == y = isSubsequenceOf xs ys
  | otherwise = isSubsequenceOf needle ys
