#lang racket

(require "../../smolisp.rkt")

(define (public-well-scoped-0)
  (displayln (well-scoped? '1 (set '+))) 
  (displayln (well-scoped? '+ (set '+))) 
  (displayln (well-scoped? '(+ 1 2) (set '+))) 
  (displayln (well-scoped? '(let ([x 2]) x) (set '+)))
  (displayln (well-scoped? '(let ([x 0]) (let ([y 1]) (+ x y))) (set '+))))

(public-well-scoped-0)

(with-output-to-file "output"
  (lambda ()
    (public-well-scoped-0))
  #:exists 'replace)
