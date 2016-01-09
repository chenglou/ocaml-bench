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

- access time, small record vs obj (cached): record access is **much** faster than object access, by an order of magnitude. But consider that these two are both extremely fast.

- access time with mutable + heap allocated value, record vs obj (cached): the hope was that object field caching (if that still exists) would help here, but no. Also, accessing a field that's mutable + holds heap value should be much slower than normal access, but I didn't find a way to fairly test both. If we compare `accessRec` and `mutHeapValueAccessRec`, the code and the result aren't too different. It's 3x difference but the latter has a `List.hd` call.

- access time, obj cached vs uncached (open, small): insignificant

- access time, open vs closed obj: closed always slightly faster, but insignificant.

- creation time, small record vs obj: object always slightly slower. Not very significant.

- creation time, big record vs obj: object always 1.5x **faster**! Is there some laziness involved?

- update time, record vs obj, small: object twice slower.

- update time, record vs obj, big: **insignificant**.
