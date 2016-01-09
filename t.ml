(* to store value of a record/obj. To avoid constant lifting of record *)
Random.self_init ();;

(* don't use ref/Sys.time in loops, they cause write barrier in assembly. Random
doesn't *)

(* bench speeds take into consideration function creation, calling, and other
noise.  That's ok; we're comparing relative speed of record vs obj, so the noise
cancel each other out *)
print_endline "access time, small record vs obj (cached)";;
type reco = {a: int};;
(* prevent constant folding of record field access *)
let rrr = {a = Random.int 10};;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + rrr.a);;
let start = Sys.time ();;
(* these prints do nothing, ignore the result. They're to trick the compiler not
to dead code eliminate the previous operations *)
print_int (bla 9999999 0);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

type obj = <a: int>;;
let ooo: obj = object method a = (Random.int 10) end;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + ooo#a);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

print_endline "access time with mutable + heap allocated value, small record vs obj (cached)";;
(* these will create a write barrier per access, which possibly indicate real
life perf better (we don't know for sure though); anyway, the results are here *)

(* in principle, there's no point benchmarking this; the record has a straight
mutable field while the obj is a field that points to a ref (which itself is a
record with one field). So obj should always be slower. However, it caches the
access result, so we never know... *)
type reco1 = {mutable a: int list};;
(* prevent constant folding of record field access *)
let rrr = {a = [Random.int 10]};;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + List.hd rrr.a);;
let start = Sys.time ();;
(* these prints do nothing, ignore the result. They're to trick the compiler not
to dead code eliminate the previous operations *)
print_int (bla 9999999 0);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

type objz = <a: int list ref>;;
let ooo: objz = object method a = ref [Random.int 10] end;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + List.hd !(ooo#a));;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

print_endline "access time, obj cached vs uncached (open, small)";;
let arr = Array.make 10000000 (object method c = (Random.int 10) end);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n)#c);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

let arr = Array.init 10000000 (fun _ -> object method cc = (Random.int 10) end);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n)#cc);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

print_endline "creation time, small record vs obj";;
type someRec = {a: int};;
let start = Sys.time ();;
let arr = Array.init 10000000 (fun _ -> {a = Random.int 10});;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n).a);;
print_int (bla 9999999 0);;

(* pragma split *)

type someObj = <a: int>;;
let start = Sys.time ();;
(* explicitly annotate, so that it doesn't generate a brand new <a: int> type *)
let f (_: int): someObj = object method a = (Random.int 10) end;;
let arr = Array.init 10000000 f;;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n)#a);;
print_int (bla 9999999 0);;

(* pragma split *)

(* I've removed the tests for access of big records/obj. Both former and latter
should be constant speed *)

print_endline "access time, open vs closed obj";;
let rec bla n acc o =
  if n = 0 then acc
  else bla (n - 1) (acc + o#gg) o;;
let start = Sys.time ();;
print_int (bla 9999999 0 (object method gg = Random.int 10 end));;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

let rec bla n acc (o: <ggg: int>) =
  if n = 0 then acc
  else bla (n - 1) (acc + o#ggg) o;;
let start = Sys.time ();;
print_int (bla 9999999 0 (object method ggg = Random.int 10 end));;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

print_endline "update time, record vs obj, small";;
type recked = {a: int};;
let rec bla n acc o =
  if n = 0 then acc
  else bla (n - 1) (acc + o.a) {o with a = Random.int 10};;
let start = Sys.time ();;
print_int (bla 9999999 0 {a = Random.int 10});;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

let noChoice = object
  val _ok = Random.int 10
  method ok = _ok
  method up = {<_ok = Random.int 10>}
end
let rec bla n acc o =
  if n = 0 then acc
  else bla (n - 1) (acc + o#ok) o#up;;
let start = Sys.time ();;
print_int (bla 9999999 0 noChoice);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

print_endline "update time, record vs obj, big";;
type myRecord2 = {
  a: int;
  b: int;
  c: float;
  d: float;
  e: string;
  f: string;
  g: int list;
  h: int list;
  i: int
};;
let last = {
  a = 0;
  b = 1;
  c = 0.;
  d = 1.;
  e = "hi";
  f = "bye";
  g = [1; 2];
  h = [1; 2];
  i = Random.int 10
};;
let rec bla n acc o =
  if n = 0 then acc
  else bla (n - 1) (acc + o.a) {o with i = Random.int 10};;
let start = Sys.time ();;
print_int (bla 9999999 0 last);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

let last = object
  method a = 0;
  method b = 1;
  method c = 0.;
  method d = 1.;
  method e = "hi";
  method f = "bye";
  method g = [1; 2];
  method h = [1; 2];
  val _i = Random.int 10;
  method i = _i;
  method up = {<_i = Random.int 10>}
end;;
let rec bla n acc o =
  if n = 0 then acc
  else bla (n - 1) (acc + o#i) o#up;;
let start = Sys.time ();;
print_int (bla 9999999 0 last);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;

(* pragma split *)

print_endline "creation time, big record vs obj";;
type myRecord3 = {
  a: int;
  b: int;
  c: float;
  d: float;
  e: string;
  f: string;
  g: int list;
  h: int list;
  i: int
};;
let start = Sys.time ();;
let arr = Array.init 10000000 (fun _ -> {
  a = 0;
  b = 1;
  c = 0.;
  d = 1.;
  e = "hi";
  f = "bye";
  g = [1; 2];
  h = [1; 2];
  i = Random.int 10
});;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n).a);;
print_int (bla 9999999 0);;

(* pragma split *)

let start = Sys.time ();;
(* explicitly annotate, so that it doesn't generate a brand new <a: int> type *)
let f (_: int): someObj = object method a = (Random.int 10) end;;
let arr = Array.init 10000000 (fun _ -> object
  method a = 0;
  method b = 1;
  method c = 0.;
  method d = 1.;
  method e = "hi";
  method f = "bye";
  method g = [1; 2];
  method h = [1; 2];
  val _i = Random.int 10;
  method i = _i;
  method up = {<_i = Random.int 10>}
end);;
Printf.printf "\nExecution time: %f.\n" (Sys.time () -. start);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n)#a);;
print_int (bla 9999999 0);;
