# Project 3: Smolisp

You will implement Smolisp, a dynamically-scoped subset of Racket that
allows using `define` to define first-order functions. Expressions
include literals, variables, let-binding and let*, if, cond, and
function calls. Crucially, however, functions may *only* be invoked by
name (i.e., no lambdas allowed), and functions may not return other
functions. You will also support a collection of "builtin"
functions. Smolscm programs consist of a set of top-level definitions
which are either variables or function definitions. Functions are
defined using the `(define (f args ...)  e-body)` syntax. For example,
the following is a Smolscm program which computes the factorial of 10:

```
(define factorial
  '((define (fac n)
      (if (= n 0)
          1
          (* n (fac (- n 1)))))
    (fac 10)))
```

Notice that we use the quote to begin a list of definitions (in this
case, the single definition of fac) before a single "main" expression.

Note: using Racket's built-in `eval` will not help, as this language
has a different semantics. **Do not** use Racket's `eval`.

# Language and Semantics

Smolisp programs consist of expressions and top-level definitions
(defined using `(define (f x ...) ...)` or `(define x
...)`). Expressions are characterized by the predicate `expr?` in the
project file, and . That predicate defines the syntax of the language
(i.e., valid Smolisp expressions).

Our language is quite a bit like Racket, but has several features that
make it subtly different from Racket's semantics:

- There are no first-order functions in Smolscm. For example, it is
  not possible to return a function or apply anything other than a
  function by name. For example, the following are valid:

```
(+ (f 1) (g 2 3))
(f (f 1 2) 3)
```

But the following are not:

```
((lambda (x) x) x)
(define (foo x) +)
```

- A consequence is that all callsites will call *named* functions,
  which must previously have been defined using the special `(define
  ...)` construct.

- Only top-level function / variable definitions are allowed. A
  program consists of a (possibly-empty) sequence of definitions
  followed by a final "main" expression. A definition may not appear
  under another definition.

- Smolisp is *dynamically* scoped, rather than lexically scoped. This
  means that function application should extend the environment *at
  the point of the callsite*, rather than the environment saved
  alongside the closure. For example, consider the following code:

```
(define x 23)
(define (foo y) x)
(define (bar x) (foo x))
(bar 42)
```

In Smolisp, the result of this code will be 42, but in Racket it will
be 23. This is because Racket is *lexically* scoped: variables'
binders are derived from their syntactically-proximate definitions,
rather than their proximate definition on the stack. This difference
can feel extremely subtle, and was famously mis-implemented by
McCarthy in the original Lisp. Solving this problem requires tracking
the environment at the definition of each function (using "closures");
we will discuss an interpreter in class very soon which demonstrates
this.

## Expressions

Expressions consist of a large subset of forms from Scheme:

- Literals: you must support numbers, booleans, and the literal empty
  list `'()` (caution: you need to *match* this as ''(), be careful to
  note this.)
- Short-circuiting binary and / or: 
- Builtins: you must support the following builtins: *, +, -, /,
  zero?, null?, cons, car, cdr.
- let and let* can be used with any number of binding pairs
  (including zero, for example, `(let () 1)` which is equivalent 
  to `1`. Remember to use the "sequenced let" interpretation for 
  let*
- cond optionally ends with an `else` clause (clauses after the 
  `else` are ignored as dead code). If no suitable clause
  exists, you should return 0 (e.g., Racket returns 
  `(void)` for `(cond [(= 1 2) 3])` but you should return 0).
- Application of fixed-arity functions, `(f x (+ y 1))`. This match
  pattern goes last to avoid matching more specific patterns (like
  `cond`).

## Definitions

Smolisp has two types of definitions: function definitions and
variable definitions. Functions are defined as:

```
(define (foo args ...) e-body)
;; For example
(define (foo x y) (+ x y))
(define (bar) 3)
;; But not this (more than one body expression):
(define (baz x y) x y)
```

Where `e-body` is an expression and all of `foo` and all arguments are
symbols. Variables may also be defined:

```
(define x expr)
``` 

Where `expr` is an expression.

Notice that definitions may not nest. A definition must contain an
expression as its body, but specifically may not contain another
definition. The following is specifically an error:

```
;; Allowable in Racket--not in Smolisp
(define (foo x)
  (define (baz y) y)
  (baz x))
```

## Programs

Programs contain a (possibly empty) list of definitions, followed by a
final expression. For example, each of the following is a program:

```
(+ 2 3)
((define x 12) x)
((define (bar x) (+ x 2)) (define (foo x) (bar (* x 2))) (foo (bar 3)))
```

# Requirements

You will implement two functions:

- `well-scoped`: Takes a Smolisp expression (and an environment, given
  as a `set` of variables) and returns whether it is well-scoped or
  not. For this one, you should be using recursion and think carefully
  about the binding structure: `let` is the only form which introduces
  new bindings. Returns #t when the expression is well-scoped (i.e.,
  contains no identifiers outside of the environment passed in) and #f
  otherwise.

- `eval-expr`: This is the main function you will implement. The match
  cases of the function are stubbed out for you, but you must
  implement each of the cases.

Think of `well-scoped` as a warmup: it largely involves matching and
traversing expressions. You should use a match pattern similar to that
in `eval-expr`, so feel free to copy that as a template.

# Implementation Guide, Hints, etc...

- Literals evaluate to themselves, and variables map to their meaning
  in the environment (i.e., via hash-ref). Each of those cases should
  be straightforward.

- `let` and `let*` can be handled by using a `foldl` that accumulates
  a new environment (starting with the current environment) and then
  executes the body in this new (updated) environment. 

- `cond` should walk over each guard, evaluating each, until it hits
  one that evaluates to `#t`. Once it does, it should evaluate the
  corresponding body and return its value.

- Function application should evaluate each of the arguments to a
  value, then bind the appropriate formal parameter in the current
  environment.

- `and` and `or` should evaluate the first expression. If it's true
  you should return #t/#f, otherwise evaluate the rest of the
  expressions.

- Think carefully about how to implement builtins. There are a variety
  of ways to do it. My reference solution adds them to the
  environment, which is preferable for several reasons. Though it may
  also work to match them as special cases of function application.
# CIS352 Project 3 Smolisp DrRacket
# WeChat: cstutorcs

# QQ: 749389476

# Email: tutorcs@163.com

# Computer Science Tutor

# Programming Help

# Assignment Project Exam Help
