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

- access time, small record vs obj (cached): record access is 30x faster than object access. But consider that these two are both very fast.

- access time with mutable + heap allocated value, record vs obj (cached): makes object access only twice slower. Hypothesis: write barrier drags record field access time down + object field caching helped.

- access time, obj cached vs uncached (open, small): insignificant, with uncached being... slightly faster?

- access time, open vs closed obj: insignificant.

- creation time, small record vs obj: object always slightly slower. Not very significant.

- creation time, big record vs obj: object always 1.5x **faster**! Is there some laziness involved?

- update time, record vs obj, small: object twice slower.

- update time, record vs obj, big: object **barely** slower.

## Sample result

```
File "updateRecSmall.ml", line 6, characters 31-57:
Warning 23: all the fields are explicitly listed in this record:
the 'with' clause is useless.
=========start benchmarks=========

access time, small record vs obj (cached)
49999995
Record time: 0.015208.
45003292
Object time: 0.351087.

access time with mutable + heap allocated value, record vs obj (cached)
79999992
Record time: 0.035720.
39999996
Object time: 0.079826.

access time, obj cached vs uncached (open, small)
44998861
Cached time: 0.396473.
44993637
Non-cached time: 0.386127.

access time, open vs closed obj
45005364
Open time: 0.340496.
45000628
Closed time: 0.353448.

creation time, small record vs obj
44989513
Record time: 1.491161.
45002089
Object time: 1.635870.

creation time, big record vs obj
45007085
Record time: 3.683870.
45001413
Object time: 2.192437.

update time, record vs obj, small
45015794
Record time: 0.346690.
44989103
Object time: 0.616129.

update time, record vs obj, big
44992502
Record time: 0.628196.
45000175
Object time: 0.668704.
```
