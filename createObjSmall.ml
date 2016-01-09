Random.self_init ();;

type someObj = <a: int>;;
(* explicitly annotate, so that it doesn't generate a brand new <a: int> type *)
let f (_: int): someObj = object method a = (Random.int 10) end;;
let start = Sys.time ();;
let arr = Array.init 10000000 f;;
let time = Sys.time () -. start;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n)#a);;
print_int (bla 9999999 0);;
Printf.printf "\nObject time: %f.\n" time;;
