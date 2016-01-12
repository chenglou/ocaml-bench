open Core.Std
open Core_bench.Std

Random.self_init ();;

type t1 = {a: int}

let rec test_record r n accum =
  if n = 0 then ()
  else test_record {a = Random.int 10} (n - 1) (accum + r.a)

let rec test_obj o n accum =
  if n = 0 then ()
  else test_obj (object
    val _a = Random.int 10
    method a = _a
  end) (n - 1) (accum + o#a)

let () =
  let tests = [
    Bench.Test.create ~name:"create small record"
      (fun () -> test_record {a = Random.int 10} 100000 0);
    Bench.Test.create ~name:"create small object"
      (fun () -> test_obj (object
        val _a = Random.int 10
        method a = _a
      end) 100000 0)
  ] in
  Bench.make_command tests |> Command.run;
