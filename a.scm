(define (list-index pred list-)
    (define (list-index pred list- index)
        (cond
            ((null? list-) -1)
            ((pred (car list-)) index)
            (else (list-index pred (cdr list-) (+ 1 index)))
        )
    )
    (list-index pred list- 0)
)

(define (remove-by-index list- i)
    (if (null? list-)
        null
        (if (= i 0)
            (cdr list-)
            (cons (car list-) (remove-by-index (cdr list-) (- i 1)))
        )
    )
)

(define (delete-first-match pred list_)
    (remove-by-index list_ (list-index pred list_))
)

(define (1+ . terms)
    (apply + (cons 1 terms))
)

(define (average . numbers)
    (if (null? numbers)
        (error "'numbers' must be non-empty")
    )
    (define (average numbers acc i)
        (if (null? numbers)
            (/ acc i)
            (average (cdr numbers) (+ acc (car numbers)) (+ 1 i))
        )
    )
    (average numbers 0 0)
)

; Exercise 1.3
(define (sum-squares-of-2-largest-numbers a b c)
    (define (sum-squares a b) (+ (square a) (square b)))

    (define (sum-squares-of-2-largest-numbers ns l1 l2)
        (if (null? ns)
            (sum-squares l1 l2)
            (let ((n (car ns)))
                (cond
                    ((> n l1) (sum-squares-of-2-largest-numbers (cdr ns) n l1))
                    ((> n l2) (sum-squares-of-2-largest-numbers (cdr ns) l1 n))
                    (else (sum-squares-of-2-largest-numbers (cdr ns) l1 l2))
                )
            )
        )
    )
    (sum-squares-of-2-largest-numbers (list a b c) 0 0)

    ; (define (sum-squares-of-2-largest-numbers ns)
    ;     (let* (
    ;             (n1 (apply max ns))
    ;             (ns2 (delete-first-match (lambda (x) (= x n1)) ns))
    ;             (n2 (apply max ns2))
    ;         )
    ;         (sum-squares n1 n2)
    ;     )
    ; )
    ; (sum-squares-of-2-largest-numbers (list a b c))
)

; Exercise 1.5 {{{
(define (p) (p))
(define (test x y)
    (if (= x 0) 0 y)
)
; (test 0 (p))
; }}}


; Exercise 1.16 {{{

; (define (pow n p)
;     (cond
;         ((= p 0) 1)
;         ((even? p) (pow (square n) (/ p 2)))
;         (else (* n (pow n (- p 1))))
;     )
; )
(define (pow n p)
    (define (pow n p acc)
        (cond
            ((= p 0) acc)
            ((even? p) (pow (square n) (/ p 2) acc))
            (else (pow n (- p 1) (* acc n)))
        )
    )
    (pow n p 1)
)

; }}}

; (define (pow-mod n p m)
;     (cond
;         ((= p 0) 1)
;         ((even? p) (remainder
;             (pow-mod (square n) (/ p 2) m) m
;         ))
;         (else (remainder
;             (* n (pow-mod n (- p 1) m)) m
;         ))
;     )
; )
(define (pow-mod n p m)
    (define (mod x) (remainder x m))
    (define (pow-mod n p acc)
        (cond
            ((= p 0) acc)
            ((even? p) (pow-mod
                (mod (square n)) (/ p 2) (mod acc)
            ))
            (else (pow-mod
                (mod n) (- p 1) (mod (* acc n))
            ))
        )
    )
    (pow-mod n p 1)
)

; Exercise 1.18 {{{
(define (mul a b)
    (define (double a) (* a 2))
    (define (halve a) (/ a 2))
    (define (mul a b acc)
        (cond
            ((= b 0) acc)
            ((even? b) (mul (double a) (halve b) acc))
            (else (mul a (- b 1) (+ acc a)))
        )
    )
    (mul a b 0)
)
; }}}

; Exercise 1.21 & Exercise 1.23 {{{
(define (divides? a b) (= (remainder b a) 0))
(define (smallest-divisor n)
    (define (find-divisor n test-divisor step)
        (cond
            ((> (square test-divisor) n) n)
            ((divides? test-divisor n) test-divisor)
            (else (find-divisor n (+ test-divisor step) 2))
        )
    )
    (find-divisor n 2 1)
)

; (smallest-divisor 199)
; (smallest-divisor 1999)
; (smallest-divisor 1999)
; (smallest-divisor 19999)

; }}}

(define (prime? n)
    (= n (smallest-divisor n))
)

; Exercise 1.22 {{{
(define (timed-prime-test n)
    (display n) (newline)
    (start-prime-test n (runtime))
)
(define (start-prime-test n start-time)
    (if (prime? n)
        (begin
            (report-prime (- (runtime) start-time))
            #t
        )
        #f
    )
)
(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time)
)

(define (search-for-primes number max-count)
    (define (search-for-primes number max-count count)
        (if (< count max-count)
            (let (
                    (is-prime (timed-prime-test number))
                )
                (search-for-primes
                    (+ 2 number)
                    max-count
                    (if is-prime (+ 1 count) count)
                )
            )
        )
    )
    (search-for-primes (if (even? number) (- number 1) number) max-count 0)
)

; (search-for-primes 1000 3)
; (search-for-primes 10000 3)
; (search-for-primes 100000 3)
; (search-for-primes 1000000 3)

; Laptop too fast

; }}}

; Exercise 1.29 {{{
(define (Simpson-integral a b f n)
    (if (not (even? n))
        (error "'n' is not even" n)
    )
    (let* (
            (h (/ (- b a) n))
            (y (lambda (k)
                (* (f (+ a (* k h)))
                    (cond
                        ((or (= k 0) (= k n)) 1)
                        ((odd? k) 4)
                        ((even? k) 2)
                    )
                )
            ))
        )
        (* (/ h 3) (sum y 0 n))
    )
)
; }}}


; Exercise 1.30 & 1.32 {{{
(define (fold-map bin-op bin-op-identity mapper a b next)
    (define (fold-map a acc)
        (if (> a b)
            acc
            (fold-map (next a) (bin-op acc (mapper a)))
        )
    )
    (fold-map a bin-op-identity)
)

(define (sum mapper a b)
    (fold-map + 0 mapper a b 1+)
)
; }}}

; Exercise 1.31 {{{

; pi   2 * 2 * 4 * 4 * 6 * 6 * 8 * 8 * ...
; -- = -----------------------------------
;  2   1 * 3 * 3 * 5 * 5 * 7 * 7 * 9 * ...

(define (John-Wallis-pi n)
    (* 2
        (fold-map
            * 1
            (lambda (x)
                (/ (square x) (* (- x 1) (+ x 1)))
            )
            2 (* 2 n)
            (lambda (x) (+ 2 x))
        )
    )
)
;}}}

; Exercise 1.33 {{{
; TODO
; }}}

; Exercise 1.34 {{{
(define (f g) (g 2))
; (f f)
; }}}

; Exercise 1.35 {{{

; `#!optional` and `default-object?` is not a Scheme standard,
; but an mit-scheme extension.

(define (fixed-point f first-guess . tolerance)
; (define (fixed-point f first-guess #!optional tolerance)

    (define tolerance-
        (if (null? tolerance) 0.00001 (car tolerance))
        ; (if (default-object? tolerance) 0.00001 tolerance)
    )

    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance-)
    )
    (define (try guess)
        (display guess) (newline)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try
                    ; next  ; No "Average Damping"
                    (average next guess)  ; "Average Damping"
                )
            )
        )
    )
    (try first-guess)
)

; (fixed-point (lambda (x) (/ (log 1000) (log x))) 2. 0)

; }}}

; Exercise 1.37
; Exercise 1.38
; Exercise 1.39 {{{
; TODO
; }}}
