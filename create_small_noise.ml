Random.self_init ();;

let start = Sys.time ();;
let arr = Array.init 10000000 (fun _ -> (Random.int 10));;
let time = Sys.time () -. start;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n));;
print_int (bla 9999999 0);;
Printf.printf "\nNoise time: %f.\n" time;;
