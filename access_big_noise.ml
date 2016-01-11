let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + 5);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nNoise time: %f.\n" (Sys.time () -. start);;
