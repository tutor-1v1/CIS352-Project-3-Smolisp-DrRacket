#lang racket

(provide (all-defined-out)) ;; don't remove

;; CIS352 -- Project 3 -- Implementing Smolisp
;; 
;; Smolisp is a stripped-down version of Racket with top-level
;; definitions but no higher-order functions. Expressions include
;; literals, variables, let-binding and let*, if, cond, and function
;; calls. Crucially, however, functions may not appear without being
;; invoked by name. Your implementation must provide a collection of
;; "builtin" functions listed below

;; function names are symbols
(define function-name? symbol?)

;; BEGIN LANGUAGE DEFINITION

;; Smolisp expressions (may not include definitions)
(define (expr? e)
  (match e
    ;; Literal numbers and booleans
    [(? number? n) #t]
    [(? boolean? n) #t]
    ;; the literal symbol '(), as in '(cons 1 '())--notice the double
    ;; quote
    [''() #t]
    ;; Variable names, note that evaluating a function is an
    ;; error--function names must only appear in call position.
    [(? symbol? x) #t]
    ;; let-binding some list of symbols xs and list of expressions es:
    ;; E.g., in '(let ([x 0] [y z]) x), xs would be '(x y), es would
    ;; be '(0 z), and e-body would be x
    [`(let ([,(? symbol? xs) ,(? expr? es)] ...) ,(? expr? e-body)) #t]
    ;; let* is sequenced let
    [`(let* ([,(? symbol? xs) ,(? expr? es)] ...) ,(? expr? e-body)) #t]
    ;; if branching
    [`(if ,(? expr? e-guard) ,(? expr? e-true) ,(? expr? e-false)) #t]
    ;; short-circuiting and/or
    [`(and ,(? expr? e0) ,(? expr? e1)) #t]
    [`(or ,(? expr? e0) ,(? expr? e1)) #t]
    ;; conds may optionally (but not necessarily) end in `[else ...]`,
    ;; every case after the `else` case is dead code.
    [`(cond [,(? expr? cond-guards) ,(? expr? cond-bodies)] ...) #t]
    ;; function calls must specify a name (no lambdas!)
    [`(,(? expr? f) ,(? expr? e-arguments) ...) #t]
    ;; Nothing else is a Smolisp expression
    [_ #f]))

;; A top-level definition defines either a function (of some number
;; of arguments)
(define (definition? d)
  (match d
    ;; defining a function with a fixed set of arguments
    [`(define (,(? function-name? fn) ,(? symbol? xs) ...) ,(? expr? body)) #t]
    ;; defining a variable
    [`(define ,(? symbol? x) ,(? expr? defn)) #t]
    [_ #f]))

;; In this project, we consider "first-order" functions--functions
;; must be defined in a top-level definition (no lambdas) and
;; thus associated with a name. Our environment maps functions to
;; a special '(function (x0 ...) e-body) form

;; Is it a base value (not a function)
(define (base-value? ev)
  (match ev
    [(? boolean?) #t]
    [(? number?) #t]
    [(? list?) #t]
    [_ #f]))

;; Values may also include functions, but no expression may evaluate
;; to a value.
(define (value? ev)
  (match ev
    ;; base values: numbers, booleans, and lists of values
    [(? base-value? bv) #t]
    ;; first-order functions over some number (0 or more) of variables
    [`(function (,(? symbol? xs) ...) ,(? expr? e-body)) #t]
    ;; nothing else
    [_ #f]))

;; Environments are maps from variables to values, which are
;; either base values or tagged functions with some number
;; of arguments
(define (environment? env)
  (and (hash? env)
       (andmap (λ (key) (symbol? key)) (hash-keys env))
       (andmap (λ (value) (value? value)) (hash-values env))))

;; A program is a sequence of top-level definitions (either function
;; or variable definitions), ending with a "main" expression which
;; will be executed.
(define (program? program)
  (match program
    [`((? definition? defns) ... ,(? expr? main-body)) #t]))

;; END LANG DEFINITION, YOUR CODE BELOW

;; TODO TODO TODO
;; takes an expression and a set of variables in scope, returns #t iff
;; the expression is well-scoped.
(define/contract (well-scoped? expr vars-in-scope)
  (-> expr? set? boolean?)
  (match expr
    [(? number? n) 'todo]
    [(? boolean? n) 'todo]
    [''() 'todo]
    [(? symbol? x) 'todo]
    [`(let ([,(? symbol? xs) ,(? expr? es)] ...) ,(? expr? e-body))
     'todo]
    ;; be careful: this one is trickier
    [`(let* ([,(? symbol? xs) ,(? expr? es)] ...) ,(? expr? e-body))
     'todo]
    [`(if ,e0 ,e1 ,e2)
     'todo]
    [`(and ,e0 ,e1) 'todo]
    [`(or ,e0 ,e1) 'todo]
    [`(not ,e) 'todo]
    [`(,f ,es ...)
     'todo]))

;; TODO TODO TODO
;; eval-expr evaluates an expression in an environment
(define/contract (eval-expr expr env)
  (-> expr? environment? base-value?)
  (match expr
    ;; For literal values, just return them
    [(? number? n) 'todo]
    [(? boolean? n) 'todo]
    [''() 'todo]
    ;; For variables: look them up in the environment.
    [(? symbol? x) 'todo]
    ;; let-binding some list of symbols xs and list of expressions es:
    ;; E.g., in '(let ([x 0] [y z]) x), xs would be '(x y), es would
    ;; be '(0 z), and e-body would be x
    [`(let ([,(? symbol? xs) ,(? expr? es)] ...) ,(? expr? e-body))
     'todo]
    [`(let* ([,(? symbol? xs) ,(? expr? es)] ...) ,(? expr? e-body)) 
     'todo]
    ;; To evaluate if: first evaluate the guard, if it evaluates to
    ;; #t, evaluate the true branch, else evaluate the false branch.
    [`(if ,(? expr? e-guard) ,(? expr? e-true) ,(? expr? e-false))
     'todo]
    ;; For cond: evaluate each expression one after the other
    [`(cond [,(? expr? cond-guards) ,(? expr? cond-bodies)] ...)
     'todo]
    ;; For and / or: remember to short-circuit
    [`(and ,e0 ,e1) 'todo]
    [`(or ,e0 ,e1) 'todo]
    ;; For not: evaluate the expression--if #t, return #f, otherwise #t
    [`(not ,e) 'todo]
    ;; Functions applied to a fixed number of arguments
    [`(,(? expr? f) ,(? expr? e-arguments) ...)
     ;; hint: f should map (via hash-ref of env) to something like
     ;; '(function (x ...) ...)--how can you match this to get
     ;; the variables and body
     'todo]
    [_ (error "unexpected expression")]))

;; Add a definition to the environment
(define (add-definition next-defn env)
  (match next-defn
    [`(define (,(? symbol? f) ,xs ...) ,e-body)
     (hash-set env f `(function (,@xs) ,e-body))]
    [`(define ,x ,e)
     (hash-set env x (eval-expr e env))]))

;; Builtins: you must handle the following builtins
;; + * - / = < > equal? cons null? car cdr
;;
;; TODO: give this a sensible definition that works with your interpreter
(define builtins
  (hash))

;; Interpreting a program involves building up an environment,
;; starting from the initial environment of builtins, and then finally
;; using that environment to evaluate the expression.
(define (interpret-program prog)
  (match prog
    [`(,definitions ... ,main)
     (eval-expr main 
                (foldl (lambda (next-defn env) (add-definition next-defn env))
                       builtins
                       definitions))]))

;; TESTS

(define (public-well-scoped-0)
  (displayln (well-scoped? '1 (set '+))) 
  (displayln (well-scoped? '+ (set '+))) 
  (displayln (well-scoped? '(+ 1 2) (set '+))) 
  (displayln (well-scoped? '(let ([x 2]) x) (set '+)))
  (displayln (well-scoped? '(let ([x 0]) (let ([y 1]) (+ x y))) (set '+))))

(define (public-well-scoped-1)
  (displayln (well-scoped? '(if (equal? (let ([x 0] [y 1]) y) 1) a b) (set 'equal? 'a 'b))) 
  (displayln (well-scoped? '(if (equal? (let ([x 0] [y 1]) y) 1) x y) (set 'equal?))) 
  (displayln (well-scoped? '(if (and (or a #t) (not (equal? (let ([x 0] [y 1]) y) 1))) 2 3)  (set 'equal? 'a))))

(define (public-builtin-0)
  (displayln (interpret-program '((+ (- 1 3) (- 10 (/ 50 (- 15 10))))))))

(define (public-builtin-1)
  (displayln (interpret-program '((null? '()))))
  (displayln (interpret-program '((null? (cons 1 '()))))))

(define (public-let-if)
  (displayln (interpret-program '((let* ([x 3] [y (* x 2)])
                                    (if (= y x)
                                        (* y (+ x 2))
                                        (if (equal? y y)
                                            (+ y 3)
                                            #f)))))))

(define (public-dynamic-scope)
  (displayln (interpret-program '((define x 23)
                                  (define (foo y) x)
                                  (define (bar x) (foo x))
                                  (bar 42)))))

(define (public-let-0)
  (displayln (interpret-program '((let ([a 0] [b 1]) a))))
  (displayln (interpret-program '((let ([a 0] [b 1]) b)))))

(define (public-let-1)
  (displayln (interpret-program '((let ([a 0] [b 1]) (let ([a 2]) a)))))
  (displayln (interpret-program '((let ([a 0] [b 1]) (let ([a a]) a))))))

(define (public-letstar-0)
  (displayln (interpret-program '((let* ([a 2] [b 1] [c b] [d (+ c (* a b))]) d)))))

(define (public-cond-0)
  (displayln (interpret-program '((cond [(= 0 1) 0] [(= 1 2) 1] [(= 2 2) 3] [else 4]))))
  (displayln (interpret-program '((cond [(= 1 1) 0] [(= 1 2) 1] [(= 2 2) 3] [else 4]))))
  (displayln (interpret-program '((cond [(= 4 1) 0] [(= 2 2) 1] [(= 2 2) 3] [else 4]))))
  (displayln (interpret-program '((cond [(= 4 1) 0] [(= 4 2) 1] [(= 4 2) 3] [else 4])))))

(define (public-factorial)
  (define factorial
    '((define (fac n)
        (if (= n 0)
            1
            (* n (fac (- n 1)))))
      (fac 10)))
  (displayln (interpret-program factorial)))


(define (public-filter)
  (define filter
    '((define (filter-pos l)
        (if (null? l)
            '()
            (if (or (> (car l) 0) (= (car l) 0))
                (cons (car l) (filter-pos (cdr l)))
                (filter-pos (cdr l)))))
      (filter-pos (cons -1 (cons 5 (cons -3 (cons 4 (cons 3 (cons 0 (cons 1 (cons -1 (cons 0 '()))))))))))))
  (displayln (interpret-program filter)))


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



