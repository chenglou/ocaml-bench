Random.self_init ();;

type reco = {a: int};;
let rrr = {a = Random.int 10};;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + rrr.a);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nRecord time: %f.\n" (Sys.time () -. start);;
