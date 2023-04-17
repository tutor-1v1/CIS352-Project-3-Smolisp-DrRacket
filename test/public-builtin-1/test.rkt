#lang racket

(require "../../smolisp.rkt")

(define (public-builtin-1)
  (displayln (interpret-program '((null? '()))))
  (displayln (interpret-program '((null? (cons 1 '()))))))

(public-builtin-1)

(with-output-to-file "output"
  (lambda ()
    (public-builtin-1))
  #:exists 'replace)
