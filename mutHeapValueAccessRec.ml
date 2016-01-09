(* these will create a write barrier per access, which possibly indicate real
life perf better (we don't know for sure though); anyway, the results are here *)
Random.self_init ();;

type reco1 = {mutable a: int list};;
let rrr = {a = [Random.int 10]};;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + List.hd rrr.a);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nRecord time: %f.\n" (Sys.time () -. start);;
