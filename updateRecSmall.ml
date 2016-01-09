Random.self_init ();;

type recked = {a: int};;
let rec bla n acc o =
  if n = 0 then acc
  else bla (n - 1) (acc + o.a) {o with a = Random.int 10};;
let start = Sys.time ();;
print_int (bla 9999999 0 {a = Random.int 10});;
Printf.printf "\nRecord time: %f.\n" (Sys.time () -. start);;
