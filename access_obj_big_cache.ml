open Core.Std
open Core_bench.Std

Random.self_init ();;

let rec test_cached cached n accum =
  if n = 0 then ()
  else test_cached cached (n - 1) (accum + cached.(n)#a)

let rec test_noncached noncached n accum =
  if n = 0 then ()
  else test_noncached noncached (n - 1) (accum + noncached.(n)#a)

let () =
  let cached = Array.create ~len:100001 (object
    method i = 0;
    method b = 1;
    method c = 0.;
    method d = 1.;
    method e = "hi";
    method f = "bye";
    method g = [1; 2];
    method h = [1; 2];
    val _a = Random.int 10;
    method a = _a;
  end) in
  let noncached = Array.init 100001 (fun _ -> object
    method i = 0;
    method b = 1;
    method c = 0.;
    method d = 1.;
    method e = "hi";
    method f = "bye";
    method g = [1; 2];
    method h = [1; 2];
    val _a = Random.int 10;
    method a = _a;
  end) in
  let tests = [
    Bench.Test.create ~name:"access big obj cached"
      (fun () -> test_cached cached 100000 0);
    Bench.Test.create ~name:"access big obj noncached"
      (fun () -> test_noncached noncached 100000 0)
  ] in
  Bench.make_command tests |> Command.run;
