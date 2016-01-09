## Comparison of various operation speeds of OCaml record vs Object

Some tricks used to make the benchmark more correct:

- Use random value generation to populate some fields. This avoids constant lifting/folding.

- Don't use ref/Sys.time in loops, as they cause write barrier in assembly.

- Benchmark speed might take into consideration some noise such as function calling. That's ok, as we're testing **relative** speed, not absolute.

- Some funny inter-object (?) caching issues affected the speed. Therefore every test case is in its respective file.

- There are some large numbers printed before each test case, to make sure the compiler doesn't dead code eliminate the relevant operations (used by the printing).

- No tests for access of big records/obj. Both former and latter
should be constant speed.

## To run
```
chmod 777 ./test.sh
./test.sh
```

## Lessons

Again, the absolute time is meaningless; it's the difference between the times that's important.

- access time, small record vs obj (cached): record access is 4x faster than object access. But consider that these two are both very fast.

- access time with mutable + heap allocated value, record vs obj (cached): makes object access only twice slower. Hypothesis: write barrier drags record field access time down + object field caching helped.

- access time, obj cached vs uncached (open, small): insignificant.

- access time, open vs closed obj: insignificant.

- creation time, small record vs obj: object always slightly slower.

- creation time, big record vs obj: object always 1.5x **faster**! Is there some laziness involved?

- update time, record vs obj, small: object twice slower.

- update time, record vs obj, big: same. Insignificant.

## Sample result

```
File "updateRecSmall.ml", line 6, characters 31-57:
Warning 23: all the fields are explicitly listed in this record:
the 'with' clause is useless.
=========start benchmarks=========

access time, small record vs obj (cached)
79999992
Record time: 0.014482.
59999994
Object time: 0.054754.

access time with mutable + heap allocated value, record vs obj (cached)
9999999
Record time: 0.033259.
19999998
Object time: 0.071915.

access time, obj cached vs uncached (open, small)
79999992
Cached time: 0.061815.
44984228
Non-cached time: 0.062184.

access time, open vs closed obj
59999994
Open time: 0.051585.
69999993
Closed time: 0.048628.

creation time, small record vs obj
45005418
Record time: 1.577238.
44999001
Object time: 2.241864.

creation time, big record vs obj
44983941
Record time: 3.817168.
44996065
Object time: 2.229992.

update time, record vs obj, small
45013943
Record time: 0.366677.
44986307
Object time: 0.669070.

update time, record vs obj, big
44984897
Record time: 0.652688.
44974243
Object time: 0.652140.```
