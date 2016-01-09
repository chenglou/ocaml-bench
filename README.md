## Comparison of various operation speeds of OCaml record vs Object

Some tricks used to make the benchmark more correct:

- Use random value generation to populate some fields. This avoids constant lifting/folding.

- Don't use ref/Sys.time in loops, as they cause write barrier in assembly.

- Benchmark speed might take into consideration some noise such as function calling. That's ok, as we're testing **relative** speed, not absolute.

- Some funny inter-object (?) caching issues affected the speed. Therefore every test case is in its respective file.

- There are some large numbers printed before each test case, to make sure the compiler doesn't dead code eliminate the relevant operations (used by the printing).

## To run
```
chmod 777 ./test.sh
./test.sh
```

## Lessons

Again, the absolute time is meaningless; it's the difference between the times that's important.

- access time, small record vs obj (cached): record access is much faster than object access. But consider that these two are both very fast.

- access time, big record vs obj (cached): more useless benchmark than it sounds. The object is cached (once), so we're basically testing whether the cache lookup itself would take time. It doesn't. Insignificant.

- access time with mutable + heap allocated value, record vs obj (cached): makes object access only twice slower (rememeber that the "twice" is between two absolute measurements and doesn't mean anything. We can only talk about differences). Hypothesis: write barrier drags record field access time down + object field caching helped.

- access time, obj cached vs uncached, small: insignificant.

- access time, obj cached vs uncached, big: insignificant. **Where did the caching benefit go?**

- access time, open vs closed obj: insignificant.

- creation time, small record vs obj: object always slightly slower.

- creation time, big record vs obj: object always 1.5x **faster**! Is there some laziness involved?

- update time, record vs obj, small: object slower.

- update time, record vs obj, big: same. Insignificant.
