(define-module (common)
    #:export (
        list-index
        remove-by-index
        delete-first-match
        1+
        average2
        average
    )
)

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

(define (average2 a b)
    (/ (+ a b) 2)
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
