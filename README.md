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

- access time with mutable + heap allocated value, record vs obj (cached): the hope was that object field caching (if that still exists) would help here, but no. Also, accessing a field that's mutable + holds heap value should be much slower than normal access, but I didn't find a way to fairly test both. If we compare `accessRec` and `mutHeapValueAccessRec`, the code and the result aren't too different. It's 3x difference but the latter has a `List.hd` call.

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
9999999
Record time: 0.013281.
45009726
Object time: 0.376059.

access time with mutable + heap allocated value, record vs obj (cached)
0
Record time: 0.038695.
44997301
Object time: 0.445683.

access time, obj cached vs uncached (open, small)
45006065
Cached time: 0.410848.
45006158
Non-cached time: 0.397027.

access time, open vs closed obj
45009944
Open time: 0.362000.
44988617
Closed time: 0.365341.

creation time, small record vs obj
44996864
Record time: 1.585582.
44997510
Object time: 1.753624.

creation time, big record vs obj
44997527
Record time: 4.086942.
44998179
Object time: 2.255656.

update time, record vs obj, small
45007243
Record time: 0.321644.
44991965
Object time: 0.680158.

update time, record vs obj, big
44985275
Record time: 0.699090.
44996427
Object time: 0.693821.
```
