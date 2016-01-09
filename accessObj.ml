Random.self_init ();;

type obj = <a: int>;;
let ooo: obj = object method a = (Random.int 10) end;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + ooo#a);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nObject time: %f.\n" (Sys.time () -. start);;
