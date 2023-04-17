#lang racket

(require "../../smolisp.rkt")

(define (public-let-1)
  (displayln (interpret-program '((let ([a 0] [b 1]) (let ([a 2]) a)))))
  (displayln (interpret-program '((let ([a 0] [b 1]) (let ([a a]) a))))))

(public-let-1)

(with-output-to-file "output"
  (lambda ()
    (public-let-1))
  #:exists 'replace)
