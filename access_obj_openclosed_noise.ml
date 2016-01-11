Random.self_init ();;

let rec bla n acc o =
  if n = 0 then acc
  else bla (n - 1) (acc + o) o;;
let start = Sys.time ();;
print_int (bla 9999999 0 (Random.int 10));;
Printf.printf "\nNoise time: %f.\n" (Sys.time () -. start);;
