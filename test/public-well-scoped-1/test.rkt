#lang racket

(require "../../smolisp.rkt")

(define (public-well-scoped-1)
  (displayln (well-scoped? '(if (equal? (let ([x 0] [y 1]) y) 1) a b) (set 'equal? 'a 'b))) 
  (displayln (well-scoped? '(if (equal? (let ([x 0] [y 1]) y) 1) x y) (set 'equal?))) 
  (displayln (well-scoped? '(if (and (or a #t) (not (equal? (let ([x 0] [y 1]) y) 1))) 2 3)  (set 'equal? 'a))))

(public-well-scoped-1)

(with-output-to-file "output"
  (lambda ()
    (public-well-scoped-1))
  #:exists 'replace)
