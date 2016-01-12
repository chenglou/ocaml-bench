## Comparison of various operation speeds of OCaml record vs Object

### To run
```
chmod 777 ./test.sh
./test.sh
```

### Lessons

Check sampleRun.txt for a demo. **Relative** time is the important thing here. Absolute time doesn't mean anything, as the test logic itself contains noise.

- access time, small record vs obj: record access is much faster than object access.

- access time, big record vs obj: object field access is supposedly log(n) (binary tree), so should be a bit slower, relative to the previous test.

- access time with mutable + heap allocated value, record vs obj: makes object access relatively faster, since one small bottleneck is the write barrier created by mutable + heap allocated value.

- access time, obj cached vs uncached, small: cached faster.

- access time, obj cached vs uncached, big: cached faster.

- access time, open vs closed obj: open slightly faster? Why?

- creation time, small record vs obj: object always slower.

- creation time, big record vs obj: object always slower.

- update time, record vs obj, small: object slower.

- update time, record vs obj, big: object slower but not by much anymore, probably involves some structural sharing, which record doesn't do for update.
