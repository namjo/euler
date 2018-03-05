import numpy as np
import pdb
from time import time

def timer(func):
    def f(*args, **kwargs):
        before = time()
        retval = func(*args, **kwargs)
        after = time()
        t = after - before
        print "elapsed time", t
        return retval
    return f


@timer
def creative_sum_pq(thres):
    """
    >>> creative_sum_pq(1000)
    8769
    >>> creative_sum_pq(100000)
    9608700
    """
    # creative_sum_q(10^10) = 308251282151324
    # creative_sum_q(10^11) = 9790954207120154
    # creative_sum_q(10^12) = 310884668312456458

    cs = -16

    B = np.log(thres)/np.log(2)
    P = Primes().iterator_range()   # prime number generator
    q = P.next()

    while q <= B:

        A = Primes().iterator_range(start = 2) # start with 2nd prime, i. e. 3, thus A.next() will be 5
        a_prime = A.next()  # instead of performing expensive prime number tests for a, just omit those a == a_prime
        a = 4
        candidate = a^q

        while candidate <= thres:
            if a < a_prime:
                g = gcd([prime_exponent[1] for prime_exponent in list(factor(a))])
                if g > 1:
                    cs += candidate/(len(prime_divisors(g)) + sign(g%q))    # if q|g prime_divisors(g) will take q into account. Otherwise we must add 1.
                else:
                    cs += candidate
                a += 1
            else:
                a_prime = A.next()
                a += 1
            candidate = a^q

        q = P.next()

    return max(0,cs)

@timer
def creative_sum_q(thres):
    """
    >>> creative_sum_q(1000)
    8769
    >>> creative_sum_q(100000)
    9608700
    """
    # creative_sum_q(10^10) = 308251282151324
    # creative_sum_q(10^11) = 9790954207120154
    # creative_sum_q(10^12) = 310884668312456458

    cs = -16

    B = np.log(thres)/np.log(2)
    P = Primes().iterator_range()   # prime number generator
    q = P.next()
    while q <= B:
        a = 2
        candidate = a^q
        while candidate <= thres:
            prime_dec = list(factor(a))     # for better amortizing we compute prime_dec in first place rather than checking is_prime(a) == False
            if len(prime_dec) > 1 or prime_dec[0][1] > 1:     # a not prime p. Otherwise had candidate = a^q = p^q uncreative
                g = gcd([prime_exponent[1] for prime_exponent in prime_dec])
                if g > 1:
                    cs += candidate/(len(prime_divisors(g)) + sign(g%q))    # if q|g prime_divisors(g) will take q into account. Otherwise we must add 1.
                else:
                    cs += candidate
            a += 1
            candidate = a^q
        q = P.next()

    return max(0,cs)

@timer
def creative_sum(thres):
    """
    >>> creative_sum(1000)
    8769
    >>> creative_sum(100000)
    9608700
    """
    # creative_sum(10^10) = 308251282151324
    # creative_sum(10^11) = 9790954207120154
    # creative_sum(10^12) = 310884668312456458

    cs = -16

    B = np.log(thres)/np.log(2)
    b = 2
    while b <= B:
        a = 2
        candidate = a^b
        while candidate <= thres:
            prime_dec = list(factor(candidate))
            g = gcd([prime_exponent[1] for prime_exponent in prime_dec])
            t = len(divisors(g))
            if t > 2:
                cs += candidate/(t-1)
            elif t == 2 and len(prime_dec) > 1:
                cs += candidate
            a += 1
            candidate = a^b
        b += 1

    return max(0,cs)


# if __name__ == "__main__":
#     import doctest
#     doctest.testmod()
