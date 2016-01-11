## Comparison of various operation speeds of OCaml record vs Object

Some tricks used to make the benchmark more correct:

- Use random value generation to populate some fields. This avoids constant lifting/folding.

- Don't use ref/Sys.time in loops, as they cause write barrier in assembly.

- Benchmark speed might take into consideration some noise such as function calling. That's ok, as we're testing **relative** speed, not absolute.

- Some funny inter-object (?) caching issues affected the speed. Therefore every test case is in its respective file.

- There are some large numbers printed before each test case, to make sure the compiler doesn't dead code eliminate the relevant operations (used by the printing).

- `_test.sh` outputs the raw values, ./test.sh does some post-processing to normalize everything (remove benchmark noise, etc.).

## To run
```
chmod 777 ./_test.sh
chmod 777 ./test.sh
./test.sh
```

## Lessons

- access time, small record vs obj (cached): record access is an order of magnitude faster than object access.

- access time, big record vs obj (cached): object field access is supposedly log(n) (binary tree), so should be a bit slower, relative to the previous test.

- access time with mutable + heap allocated value, record vs obj (cached): makes object access relatively faster, since one small bottleneck is the write barrier created by mutable + heap allocated value.

- access time, obj cached vs uncached, small: cached faster.

- access time, obj cached vs uncached, big: cached faster.

- access time, open vs closed obj: open slightly slower. Not too significant?

- creation time, small record vs obj: object always slower.

- creation time, big record vs obj: object always 1.5x **faster**! Is there some laziness involved?

- update time, record vs obj, small: object **much** slower.

- update time, record vs obj, big: more or less the same.
