#|
 | Minigrep in Scheme - Functional Style
|#

(import (chicken io)
        (chicken port)
        (chicken process-context)
        (chicken string)
        (chicken format))

;; Functional port->lines using unfold
(define (port->lines port)
  (let loop ([acc '()])
    (let ([line (read-line port)])
      (if (eof-object? line)
          (reverse acc)
          (loop (cons line acc))))))

;; Check if query is a substring of line
(define (contains-query? query line)
  (substring-index query line))

;; Get matches with line numbers
(define (get-matches query lines)
  (let loop ([lines-left lines] [line-num 1] [matches '()])
    (if (null? lines-left)
        (reverse matches)
        (let ([current-line (car lines-left)])
          (if (contains-query? query current-line)
              (loop (cdr lines-left)
                    (+ line-num 1)
                    (cons (list line-num current-line) matches))
              (loop (cdr lines-left)
                    (+ line-num 1)
                    matches))))))

;; Print a single match
(define (print-match match-elem)
  (let ([line-num (car match-elem)]
        [line (cadr match-elem)])
    (printf "~a: ~a~n" line-num line)))

;; Print all matches
(define (print-matches matches)
  (for-each print-match matches))

;; Main grep function
(define (grep query filename)
  (call-with-input-file filename
    (lambda (port)
      (let ([lines (port->lines port)])
        (let ([matches (get-matches query lines)])
          (if (null? matches)
              (printf "No matches found for '~a' in ~a~n" query filename)
              (print-matches matches)))))))

;; Error handling wrapper
(define (safe-grep query filename)
  (condition-case
    (grep query filename)
    [exn (file) (printf "Error: Could not read file '~a'~n" filename)]))

;; Main program
(let ([args (command-line-arguments)])
  (if (< (length args) 2)
      (printf "Usage: minigrep <query> <filename>~n")
      (let ([query (car args)]
            [filename (cadr args)])
        (safe-grep query filename))))
