#|
 | Minigrep in Scheme
|#

;; Takes command-line arguments and greps the file
(define (grep query filename)
  (if (not (equal? query ""))
    (if (not (equal? filename ""))
      (let ([file (open-input-file filename)])
        (if (not file)
          (display "File not found")
          (let ([lines (port->lines file)])
            (close-input-port file)
            (let ([matches (get-matches query lines)])
              (if (not (equal? matches '()))
                (print-matches matches)
                (display "No matches found"))))))
      (display "Usage: minigrep <query> <filename>"))
    (display "Usage: minigrep <query> <filename>")))

;; Returns a list of lines from a port
(define (port->lines port)
  (let ([lines '()])
    (let loop ([line (read-line port)])
      (if (not (eof-object? line))
        (begin
          (set! lines (cons line lines))
          (loop (read-line port)))
        lines))))

;; Returns a list of matches
(define (get-matches query lines)
  (let ([matches '()])
    (let loop ([i 0] [line (car lines)])
      (if (not (equal? line ""))
        (if (is-subsequence-of query line)
          (set! matches (cons (list i line) matches))
          (loop (+ i 1) (car lines)))
        matches))))

;; Prints a match
(define (print-match match-elem)
  (let ([i (car match-elem)]
        [line (cadr match-elem)])
    (display (string-append i ": " line))))

;; Prints a list of matches
(define (print-matches matches)
  (for-each print-match matches))

;; Returns true if query is a subsequence of line
(define (is-subsequence-of query line)
  (let ([i 0])
    (let loop ([i i])
      (if (equal? (substring line i (+ i 1)) (substring query i (+ i 1)))
        (if (equal? (+ i 1) (string-length query))
          true
          (loop (+ i 1)))
        false))))

(import (chicken process-context))
(define args (command-line-arguments))
(define query (car args))
(define filename (cadr args))
(grep query filename)


#|
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
|#
