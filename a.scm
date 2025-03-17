(define (list-index pred list-)
    (define (list-index- pred list- index)
        (cond
            ((null? list-) -1)
            ((pred (car list-)) index)
            (else (list-index- pred (cdr list-) (+ 1 index)))
        )
    )
    (list-index- pred list- 0)
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

; Exercise 1.3
(define (sum-squares-of-2-largest-numbers a b c)
    (define (sum-of-squares a b) (+ (square a) (square b)))

    (define (sum-squares-of-2-largest-numbers ns l1 l2)
        (if (null? ns)
            (sum-of-squares l1 l2)
            (let* (
                    (n (car ns))
                )
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
    ;         (sum-of-squares n1 n2)
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
