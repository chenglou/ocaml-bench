Random.self_init ();;

let rec bla n acc (o: <ggg: int>) =
  if n = 0 then acc
  else bla (n - 1) (acc + o#ggg) o;;
let start = Sys.time ();;
print_int (bla 9999999 0 (object method ggg = Random.int 10 end));;
Printf.printf "\nClosed time: %f.\n" (Sys.time () -. start);;
