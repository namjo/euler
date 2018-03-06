Three ways to compute the sum of all creative numbers up to a threshold `thres`. We rely on `sagemath` for the math. To doctest, run
```
sage -t craetive.sage
```

For performance measuring, uncomment the `timer` decorators.

For a neat characterization of creative numbers, please read the pdf.

Since only numbers of the form `a^b` have a chance to be creative we will only loop through these numbers, which are referred to as *candidates* in the code. The outer `while` loops through the exponents `b`, the inner `while` loops through the bases `a`. This will make us count some creative numbers multiple times which thus must be weighted.

In `creative_sum_q` we take into account that numbers of the form `a^b` where `b` is *composite* will be hit already by some `a^q` where `q` is *prime* and `b <- kq` and `a <- a^k`. The prime number theorem tells us that we can ignore `B - pi(B)` exponents.

In `creative_sum_pq` we further omit all numbers of the form `a^q` where `a` is a prime `q` since such numbers will of course not be creative. To this end we use a prime number generator in the inner `while` too. It turns out that since the bases `a` grow large and the prime density decreases, the prime generation consumes more time resources than the time in checking if such an `a` is prime via its factorization. Hence, this amortizes negatively.
