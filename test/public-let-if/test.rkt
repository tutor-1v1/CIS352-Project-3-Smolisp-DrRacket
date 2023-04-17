#lang racket

(require "../../smolisp.rkt")

(define (public-let-if)
  (displayln (interpret-program '((let* ([x 3] [y (* x 2)])
                                    (if (= y x)
                                        (* y (+ x 2))
                                        (if (equal? y y)
                                            (+ y 3)
                                            #f)))))))

(public-let-if)

(with-output-to-file "output"
  (lambda ()
    (public-let-if))
  #:exists 'replace)
