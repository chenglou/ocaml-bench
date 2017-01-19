## Comparison of various operation speeds of OCaml record vs Object

**Note** actually most of these are dead wrong. I have no idea what I'm doing. Feel free to modify the tests but don't look at the conclusion at the end!

```
lurk
@chenglou reading your bms, was scratching my head at "access time with mutable + heap allocated value, record vs obj: makes object access relatively faster, since one small bottleneck is the write barrier created by mutable + heap allocated value"  because you did not really write
as it turns out, object seems faster because you're doing (in both) one extra indirection and a float addition (instead of int), but the write barrier is not involved
(and the write barrier cost would be the same in both cases I believe)
open/closed is a fluke? I don't think typing affects performance there in any way

chenglou
^ ah that's true
@lurk can you find other stuff I've mis-benchmarked?
btw I didn't publish this because it was when I first tried benchmarking ocaml and most of the results are probably wrong

hcarty
@lurk Lookups for methods are cached in some cases but in general there is a lookup cost. Records don't have the same lookup cost since their shape is fixed

lurk
The last bm is not wrong, but not sure it's representative of anything real-like: indeed, the method table is surely shared, but the equivalent would be to use  val a = 0 +  method a = a and so on. @chenglou(edited)
create_small/create_big is maybe dominated by the Random.int call (Random is fairly slow), and then again  val xx looks like a more appropriate equivalent(edited)
in order to bm creation cost, you can use  (val)   xx = 0 everywhere fwiw(edited)
uh actually update_xx.ml are measuring the same thing as create_xx.ml, seems you forgot to change to mutation(?)  as in    mutable a : int ....   t.a <- 1  and    val mutable a = 0  method update = a <- 1

lurk
In other news, more finds: https://github.com/bmeurer/ocamljitrun    http://benediktmeurer.de/2010/11/16/ocamljit-20/    "OCamlJit 2.0 runs most benchmarks at 2-6 times faster than the byte-code interpreter. "  (but still 2-6X slower than ocamlopt according to the ML discussions)

chenglou
man i need to revamp the whole benchmark, thanks so much for the pointers

lurk
the most important thing missing is function/method call: make sure you make several calls in each iteration, otherwise the loop could dominate

chenglou
I thought the loop being in both record and obj benchmarks would cancel out

lurk
if you use a trivial function like  let f x = x + x     ignore (f 1)   (and the method equivalent), you'll get ludicrous differences in perf, because the known function call will be inlined, and the method won't(edited)

lurk
oh, it does cancel out, but it masks the actual difference because you're measuring   (overhead + time with objects) / (overhead + time with records)
where "time with records" is really small (likely smaller than overhead) in e.g. the access benchmarks
so uhm it doesn't cancel out in that sense
```

### To run
```
chmod 777 ./test.sh
./test.sh
```

### Lessons

Edit: the real lesson is that benchmarking is hard.

~~Check sampleRun.txt for a demo. **Relative** time is the important thing here. Absolute time doesn't mean anything, as the test logic itself contains noise.~~

~~- access time, small record vs obj: record access is much faster than object access.~~

~~- access time, big record vs obj: object field access is supposedly log(n) (binary tree), so should be a bit slower, relative to the previous test.~~

~~- access time with mutable + heap allocated value, record vs obj: makes object access relatively faster, since one small bottleneck is the write barrier created by mutable + heap allocated value.~~

~~- access time, obj cached vs uncached, small: cached faster.~~

~~- access time, obj cached vs uncached, big: cached faster.~~

~~- access time, open vs closed obj: open slightly faster? Why?~~

~~- creation time, small record vs obj: object always slower.~~

~~- creation time, big record vs obj: object always slower.~~

~~- update time, record vs obj, small: object slower.~~

~~- update time, record vs obj, big: object slower but not by much anymore, probably involves some structural sharing, which record doesn't do for update.~~
