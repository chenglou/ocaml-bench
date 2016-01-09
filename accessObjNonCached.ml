Random.self_init ();;

let arr = Array.init 10000000 (fun _ -> object
  val _cc = Random.int 10
  method cc = _cc
end);;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n)#cc);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nNon-cached time: %f.\n" (Sys.time () -. start);;
