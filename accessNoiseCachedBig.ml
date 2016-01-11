Random.self_init ();;

let arr = Array.make 10000000 (Random.int 10);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n));;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nNoise time: %f.\n" (Sys.time () -. start);;
