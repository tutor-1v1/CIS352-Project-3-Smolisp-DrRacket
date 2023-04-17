#lang racket

(require "../../smolisp.rkt")

(define (public-cond-0)
  (displayln (interpret-program '((cond [(= 0 1) 0] [(= 1 2) 1] [(= 2 2) 3] [else 4]))))
  (displayln (interpret-program '((cond [(= 1 1) 0] [(= 1 2) 1] [(= 2 2) 3] [else 4]))))
  (displayln (interpret-program '((cond [(= 4 1) 0] [(= 2 2) 1] [(= 2 2) 3] [else 4]))))
  (displayln (interpret-program '((cond [(= 4 1) 0] [(= 4 2) 1] [(= 4 2) 3] [else 4])))))

(public-cond-0)

(with-output-to-file "output"
  (lambda ()
    (public-cond-0))
  #:exists 'replace)
