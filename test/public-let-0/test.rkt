#lang racket

(require "../../smolisp.rkt")

(define (public-let-0)
  (displayln (interpret-program '((let ([a 0] [b 1]) a))))
  (displayln (interpret-program '((let ([a 0] [b 1]) b)))))

(public-let-0)

(with-output-to-file "output"
  (lambda ()
    (public-let-0))
  #:exists 'replace)
