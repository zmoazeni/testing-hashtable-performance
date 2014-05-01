testing-hastable-performance
============================

This is a repo to test out the performance between the [hashtables](https://hackage.haskell.org/package/hashtables) package and the HashMap from [unordered-containers](http://hackage.haskell.org/package/unordered-containers).

On my OSX machine, the unordered-containers are consistently faster.

Requirements: GHC v7.6.3, cabal-install >= 1.18

## To Run: ##

    make
    make run


## Output of a local run ##

    warming up
    estimating clock resolution...
    mean is 1.022445 us (640001 iterations)
    found 1098593 outliers among 639999 samples (171.7%)
      500173 (78.2%) low severe
      598420 (93.5%) high severe
    estimating cost of a clock call...
    mean is 48.11101 ns (8 iterations)
    found 1 outliers among 8 samples (12.5%)
      1 (12.5%) high severe

    benchmarking hashmap inserts
    mean: 42.77249 ms, lb 42.23074 ms, ub 43.38054 ms, ci 0.950
    std dev: 2.931284 ms, lb 2.550520 ms, ub 3.450863 ms, ci 0.950
    variance introduced by outliers: 63.594%
    variance is severely inflated by outliers

    benchmarking hashmap union
    mean: 38.75604 ms, lb 38.25674 ms, ub 39.32312 ms, ci 0.950
    std dev: 2.724852 ms, lb 2.382821 ms, ub 3.149132 ms, ci 0.950
    variance introduced by outliers: 64.623%
    variance is severely inflated by outliers

    benchmarking hashtable cuckoo
    collecting 100 samples, 1 iterations each, in estimated 5.484390 s
    mean: 50.78706 ms, lb 50.17328 ms, ub 51.44667 ms, ci 0.950
    std dev: 3.252150 ms, lb 2.837077 ms, ub 3.812114 ms, ci 0.950
    found 3 outliers among 100 samples (3.0%)
      3 (3.0%) high mild
    variance introduced by outliers: 60.535%
    variance is severely inflated by outliers

    benchmarking hashtable basic
    collecting 100 samples, 1 iterations each, in estimated 5.088615 s
    mean: 52.46744 ms, lb 51.90874 ms, ub 53.06552 ms, ci 0.950
    std dev: 2.986507 ms, lb 2.611857 ms, ub 3.462132 ms, ci 0.950
    found 2 outliers among 100 samples (2.0%)
      2 (2.0%) high mild
    variance introduced by outliers: 54.488%
    variance is severely inflated by outliers


