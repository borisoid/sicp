def pow(n: int, p: int) -> int:
    """Exercise 1.16"""

    return_: int = 1

    while True:
        print(f"{n=} {p=} {return_=}")

        if p == 0:
            return return_

        if p % 2 == 0:
            n = n * n
            p = p / 2
            return_ = return_

        else:
            n = n
            p = p - 1
            return_ = return_ * n


# print(pow(2, 10))
# print(pow(2, 16))

# (define (expt-iter b n a)
#     (cond ((= n 0) a)
#         ((even? n) (expt-iter (square b) (/ n 2) a))
#         (else (expt-iter b (- n 1) (* a b)))))


def max2(l: list[int]) -> int:
    l1: int = 0
    l2: int = 0

    for i in l:
        if i > l1:
            l2 = l1
            l1 = i
            continue

        if i > l2:
            l2 = i
            continue



    return l1, l2


print(max2([2, 3, 4]))
