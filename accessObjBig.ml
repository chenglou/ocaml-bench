Random.self_init ();;

let ooo = object
  method a = 0;
  method b = 1;
  method c = 0.;
  method d = 1.;
  method e = "hi";
  method f = "bye";
  method g = [1; 2];
  method h = [1; 2];
  val _i = Random.int 10;
  method i = _i;
end;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + ooo#i);;
let start = Sys.time ();;
print_int (bla 9999999 0);;
Printf.printf "\nObject time: %f.\n" (Sys.time () -. start);;
