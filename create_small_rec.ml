Random.self_init ();;

type someRec = {a: int};;
let start = Sys.time ();;
let arr = Array.init 10000000 (fun _ -> {a = Random.int 10});;
let time = Sys.time () -. start;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n).a);;
print_int (bla 9999999 0);;
Printf.printf "\nRecord time: %f.\n" time;;
