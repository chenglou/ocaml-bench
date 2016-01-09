Random.self_init ();;

let arr = Array.make 10000000 (object method c = (Random.int 10) end);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n)#c);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nCached time: %f.\n" (Sys.time () -. start);;
