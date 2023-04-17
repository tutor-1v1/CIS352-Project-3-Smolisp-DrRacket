#lang racket

(require "../../smolisp.rkt")

(define (public-dynamic-scope)
  (displayln (interpret-program '((define x 23)
                                  (define (foo y) x)
                                  (define (bar x) (foo x))
                                  (bar 42)))))

(public-dynamic-scope)

(with-output-to-file "output"
  (lambda ()
    (public-dynamic-scope))
  #:exists 'replace)
