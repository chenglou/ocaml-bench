open Core.Std
open Core_bench.Std

Random.self_init ();;

type t1 = {a: int}

let rec test_record r n accum =
  if n = 0 then ()
  else test_record r (n - 1) (accum + r.a)

let rec test_obj r n accum =
  if n = 0 then ()
  else test_obj r (n - 1) (accum + r#a)

let () =
  let r = {a = Random.int 10} in
  let o =
    object
      val _a = Random.int 10
      method a = _a
    end in
  let tests = [
    Bench.Test.create ~name:"access small record"
      (fun () -> test_record r 100000 0);
    Bench.Test.create ~name:"access small object"
      (fun () -> test_obj o 100000 0)
  ] in
  Bench.make_command tests |> Command.run;
