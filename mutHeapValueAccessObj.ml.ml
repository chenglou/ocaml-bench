(* these will create a write barrier per access, which possibly indicate real
life perf better (we don't know for sure though); anyway, the results are here *)
Random.self_init ();;

type objz = <a: int list ref>;;
let ooo: objz = object method a = ref [Random.int 10] end;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + List.hd !(ooo#a));;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nObject time: %f.\n" (Sys.time () -. start);;

(* in principle, there's no point benchmarking this; the record has a straight
mutable field while the obj is a field that points to a ref (which itself is a
record with one field). So obj should always be slower. However, it caches the
access result, so we never know... *)
