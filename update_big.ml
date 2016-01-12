open Core.Std
open Core_bench.Std

Random.self_init ();;

type t1 = {
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

let rec test_record r n accum =
  if n = 0 then ()
  else test_record {r with a = Random.int 10} (n - 1) (accum + r.i)

let rec test_obj o n accum =
  if n = 0 then ()
  else test_obj o#clone (n - 1) (accum + o#i)

let () =
  let tests = [
    Bench.Test.create ~name:"update big record"
      (fun () -> test_record {
        a = 0;
        b = 1;
        c = 0.;
        d = 1.;
        e = "hi";
        f = "bye";
        g = [1; 2];
        h = [1; 2];
        i = Random.int 10
      } 100000 0);
    Bench.Test.create ~name:"update big object"
      (fun () -> test_obj (object
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
        method clone = {<_i = Random.int 10>}
      end) 100000 0)
  ] in
  Bench.make_command tests |> Command.run;
