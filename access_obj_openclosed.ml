open Core.Std
open Core_bench.Std

Random.self_init ();;

type t1 = <a: int>

let rec test_open obj n accum =
  if n = 0 then ()
  else test_open obj (n - 1) (accum + obj#a)

let rec test_closed (obj: t1) n accum =
  if n = 0 then ()
  else test_closed obj (n - 1) (accum + obj#a)

let () =
  let op = object
    val _a = Random.int 10;
    method a = _a;
  end in
  let closed: t1 = object
    val _a = Random.int 10;
    method a = _a;
  end in
  let tests = [
    Bench.Test.create ~name:"access open"
      (fun () -> test_open op 100000 0);
      Bench.Test.create ~name:"access closed"
      (fun () -> test_closed closed 100000 0)
  ] in
  Bench.make_command tests |> Command.run;
