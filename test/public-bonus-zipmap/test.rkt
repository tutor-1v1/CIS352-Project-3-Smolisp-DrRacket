#lang racket

(require "../../smolisp.rkt")

(define (public-bonus-zipmap)
  (define p
    '((define (zip l0 l1)
        (if (null? l0)
            '()
            (cons (cons (car l0) (car l1)) (zip (cdr l0) (cdr l1)))))
      (define (maptimes lst)
        (if (null? lst)
            '()
            (cons (* (car (car lst)) (cdr (car lst))) (maptimes (cdr lst)))))
      (define (sum lst)
        (if (null? lst)
            0
            (+ (car lst) (sum (cdr lst)))))
      (sum (maptimes (zip (cons 12 (cons 15 (cons 7 '()))) (cons 3 (cons 11 (cons 12 '()))))))))
  (displayln (interpret-program p)))

(public-bonus-zipmap)

(with-output-to-file "output"
  (lambda ()
    (public-bonus-zipmap))
  #:exists 'replace)
