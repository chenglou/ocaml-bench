Random.self_init ();;

type myRecord3 = {
  a: int;
  b: int;
  c: float;
  d: float;
  e: string;
  f: string;
  g: int list;
  h: int list;
  i: int
};;
let start = Sys.time ();;
let arr = Array.init 10000000 (fun _ -> {
  a = 0;
  b = 1;
  c = 0.;
  d = 1.;
  e = "hi";
  f = "bye";
  g = [1; 2];
  h = [1; 2];
  i = Random.int 10
});;
let time = Sys.time () -. start;;
let rec bla n acc =
  if n = 0 then acc
  else bla (n - 1) (acc + arr.(n).i);;
print_int (bla 9999999 0);;
Printf.printf "\nRecord time: %f.\n" time;;
