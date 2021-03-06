testing-hastable-performance
============================

This is a repo to test out the performance between the [hashtables](https://hackage.haskell.org/package/hashtables) package and the HashMap from [unordered-containers](http://hackage.haskell.org/package/unordered-containers).

Requirements: GHC v7.6.3, cabal-install >= 1.18

## To Run: ##

    make
    make run


## Output of a local run ##

When generating a test file with 1,000 rows:

    warming up
    estimating clock resolution...
    mean is 1.037933 us (640001 iterations)
    found 1082062 outliers among 639999 samples (169.1%)
      484461 (75.7%) low severe
      597601 (93.4%) high severe
    estimating cost of a clock call...
    mean is 47.92614 ns (8 iterations)
    found 1 outliers among 8 samples (12.5%)
      1 (12.5%) high severe

    benchmarking hashmap inserts
    mean: 41.05569 ms, lb 40.63234 ms, ub 41.57861 ms, ci 0.950
    std dev: 2.395224 ms, lb 2.003822 ms, ub 2.907896 ms, ci 0.950
    found 5 outliers among 100 samples (5.0%)
      5 (5.0%) high mild
    variance introduced by outliers: 56.456%
    variance is severely inflated by outliers

    benchmarking hashmap union
    mean: 37.28463 ms, lb 36.93987 ms, ub 37.76571 ms, ci 0.950
    std dev: 2.068462 ms, lb 1.627835 ms, ub 2.992619 ms, ci 0.950
    found 10 outliers among 100 samples (10.0%)
      8 (8.0%) high mild
      2 (2.0%) high severe
    variance introduced by outliers: 53.464%
    variance is severely inflated by outliers

    benchmarking hashtable cuckoo
    mean: 33.06717 ms, lb 32.74118 ms, ub 33.50915 ms, ci 0.950
    std dev: 1.926578 ms, lb 1.502920 ms, ub 2.529431 ms, ci 0.950
    found 11 outliers among 100 samples (11.0%)
      8 (8.0%) high mild
      3 (3.0%) high severe
    variance introduced by outliers: 55.504%
    variance is severely inflated by outliers

    benchmarking hashtable basic
    mean: 32.47539 ms, lb 32.17044 ms, ub 32.97786 ms, ci 0.950
    std dev: 1.973697 ms, lb 1.343549 ms, ub 2.951638 ms, ci 0.950
    found 10 outliers among 100 samples (10.0%)
      2 (2.0%) high mild
      8 (8.0%) high severe
    variance introduced by outliers: 58.477%
    variance is severely inflated by outliers


When generating a test file with 10,000 rows:

    warming up
    estimating clock resolution...
    mean is 1.010539 us (640001 iterations)
    found 1093569 outliers among 639999 samples (170.9%)
      497138 (77.7%) low severe
      596431 (93.2%) high severe
    estimating cost of a clock call...
    mean is 52.42480 ns (8 iterations)

    benchmarking hashmap inserts
    collecting 100 samples, 1 iterations each, in estimated 48.86670 s
    mean: 522.3153 ms, lb 519.1395 ms, ub 525.8395 ms, ci 0.950
    std dev: 17.17178 ms, lb 15.04903 ms, ub 20.22974 ms, ci 0.950
    found 1 outliers among 100 samples (1.0%)
    variance introduced by outliers: 28.699%
    variance is moderately inflated by outliers

    benchmarking hashmap union
    collecting 100 samples, 1 iterations each, in estimated 38.57639 s
    mean: 462.2662 ms, lb 459.7906 ms, ub 464.8115 ms, ci 0.950
    std dev: 12.80154 ms, lb 11.25117 ms, ub 14.87192 ms, ci 0.950
    variance introduced by outliers: 21.922%
    variance is moderately inflated by outliers

    benchmarking hashtable cuckoo
    collecting 100 samples, 1 iterations each, in estimated 43.26239 s
    mean: 447.0243 ms, lb 444.8877 ms, ub 449.2720 ms, ci 0.950
    std dev: 11.23811 ms, lb 10.02587 ms, ub 12.79464 ms, ci 0.950
    variance introduced by outliers: 19.011%
    variance is moderately inflated by outliers

    benchmarking hashtable basic
    collecting 100 samples, 1 iterations each, in estimated 39.41162 s
    mean: 472.1487 ms, lb 469.6700 ms, ub 474.7883 ms, ci 0.950
    std dev: 13.12306 ms, lb 11.57042 ms, ub 15.43980 ms, ci 0.950
    found 1 outliers among 100 samples (1.0%)
    variance introduced by outliers: 21.930%
    variance is moderately inflated by outliers
