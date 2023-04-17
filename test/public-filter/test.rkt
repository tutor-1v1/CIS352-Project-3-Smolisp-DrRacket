#lang racket

(require "../../smolisp.rkt")

(define (public-filter)
  (define filter
    '((define (filter-pos l)
        (if (null? l)
            '()
            (if (or (> (car l) 0) (= (car l) 0))
                (cons (car l) (filter-pos (cdr l)))
                (filter-pos (cdr l)))))
      (filter-pos (cons -1 (cons 5 (cons -3 (cons 4 (cons 3 (cons 0 (cons 1 (cons -1 (cons 0 '()))))))))))))
  (displayln (interpret-program filter)))

(public-filter)

(with-output-to-file "output"
  (lambda ()
    (public-filter))
  #:exists 'replace)
