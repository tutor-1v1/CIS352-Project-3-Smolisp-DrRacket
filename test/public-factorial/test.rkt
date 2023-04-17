#lang racket

(require "../../smolisp.rkt")

(define (public-factorial)
  (define factorial
    '((define (fac n)
        (if (= n 0)
            1
            (* n (fac (- n 1)))))
      (fac 10)))
  (displayln (interpret-program factorial)))

(public-factorial)

(with-output-to-file "output"
  (lambda ()
    (public-factorial))
  #:exists 'replace)
