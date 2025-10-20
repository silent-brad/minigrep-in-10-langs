;; Minigrep in Fennel

(fn is-subsequence-of [query line]
  (local i 0)
  (while (< i (length query))
    (if (not= (string.sub line i (+ i 1)) (string.sub query i (+ i 1)))
      (lua "return false"))
    (lua "i = i + 1"))
  true)

(fn get-matches [query lines]
  (local matches [])
  (local i 0)
  (each [line lines]
    (if (is-subsequence-of query line)
      (table.insert matches [i line]))
    (lua "i = i + 1"))
  matches)

(fn print-match [match-elem]
  ;;(local [i line] (unpack match-elem))
  (local i (. match-elem 1))
  (local line (. match-elem 2))
  (print (.. i ": " line)))

(fn print-matches [matches]
  (each [_ match-elem (ipairs matches)]
    (print-match match-elem)))

(fn grep [query filename]
  (local file (io.open filename "r"))
  (if (not file)
    (do (print "File not found")
    (lua "return")))
  (local lines (file:lines))
  (local matches (get-matches query lines))
  (file:close)
  (if (not= matches [])
    (print-matches matches)
    (print "No matches found")))

(fn minigrep [query filename]
  (if (not= query "")
    (if (not= filename "")
      (grep query filename)
      (print "Usage: minigrep <query> <filename>"))
    (print "Usage: minigrep <query> <filename>")))
