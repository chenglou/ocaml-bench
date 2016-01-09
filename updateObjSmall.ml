Random.self_init ();;

let noChoice = object
  val _ok = Random.int 10
  method ok = _ok
  method up = {<_ok = Random.int 10>}
end
let rec bla n acc o =
  if n = 0 then acc
  else bla (n - 1) (acc + o#ok) o#up;;
let start = Sys.time ();;
print_int (bla 9999999 0 noChoice);;
Printf.printf "\nObject time: %f.\n" (Sys.time () -. start);;
