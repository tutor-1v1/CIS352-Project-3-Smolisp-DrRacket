#lang racket

(require "../../smolisp.rkt")

(define (public-builtin-0)
  (displayln (interpret-program '((+ (- 1 3) (- 10 (/ 50 (- 15 10))))))))

(public-builtin-0)

(with-output-to-file "output"
  (lambda ()
    (public-builtin-0))
  #:exists 'replace)
