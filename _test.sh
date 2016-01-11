ocamlopt access_small_noise.ml -o access_small_noise.native
ocamlopt access_small_rec.ml -o access_small_rec.native
ocamlopt access_small_obj.ml -o access_small_obj.native

ocamlopt access_big_noise.ml -o access_big_noise.native
ocamlopt access_big_rec.ml -o access_big_rec.native
ocamlopt access_big_obj.ml -o access_big_obj.native

ocamlopt access_mutHeapValue_noise.ml -o access_mutHeapValue_noise.native
ocamlopt access_mutHeapValue_rec.ml -o access_mutHeapValue_rec.native
ocamlopt access_mutHeapValue_obj.ml -o access_mutHeapValue_obj.native

ocamlopt access_obj_small_noise.ml -o access_obj_small_noise.native
ocamlopt access_obj_small_cached.ml -o access_obj_small_cached.native
ocamlopt access_obj_small_noncached.ml -o access_obj_small_noncached.native

ocamlopt access_obj_big_noise.ml -o access_obj_big_noise.native
ocamlopt access_obj_big_cached.ml -o access_obj_big_cached.native
ocamlopt access_obj_big_noncached.ml -o access_obj_big_noncached.native

ocamlopt access_obj_openclosed_noise.ml -o access_obj_openclosed_noise.native
ocamlopt access_obj_openclosed_open.ml -o access_obj_openclosed_open.native
ocamlopt access_obj_openclosed_closed.ml -o access_obj_openclosed_closed.native

ocamlopt create_small_noise.ml -o create_small_noise.native
ocamlopt create_small_rec.ml -o create_small_rec.native
ocamlopt create_small_obj.ml -o create_small_obj.native

ocamlopt create_big_noise.ml -o create_big_noise.native
ocamlopt create_big_rec.ml -o create_big_rec.native
ocamlopt create_big_obj.ml -o create_big_obj.native

ocamlopt update_small_noise.ml -o update_small_noise.native
ocamlopt update_small_rec.ml -o update_small_rec.native
ocamlopt update_small_obj.ml -o update_small_obj.native

ocamlopt update_big_noise.ml -o update_big_noise.native
ocamlopt update_big_rec.ml -o update_big_rec.native
ocamlopt update_big_obj.ml -o update_big_obj.native

echo "=========start benchmarks========="

echo "\naccess time, small record vs obj (cached)"
./access_small_noise.native
./access_small_rec.native
./access_small_obj.native
echo "\naccess time, big record vs obj (cached)"
./access_big_noise.native
./access_big_rec.native
./access_big_obj.native
echo "\naccess time with mutable + heap allocated value, record vs obj (cached)"
./access_mutHeapValue_noise.native
./access_mutHeapValue_rec.native
./access_mutHeapValue_obj.native
echo "\naccess time, obj cached vs uncached, small"
./access_obj_small_noise.native
./access_obj_small_cached.native
./access_obj_small_noncached.native
echo "\naccess time, obj cached vs uncached, big"
./access_obj_big_noise.native
./access_obj_big_cached.native
./access_obj_big_noncached.native
echo "\naccess time, open vs closed obj"
./access_obj_openclosed_noise.native
./access_obj_openclosed_open.native
./access_obj_openclosed_closed.native
echo "\ncreation time, small record vs obj"
./create_small_noise.native
./create_small_rec.native
./create_small_obj.native
echo "\ncreation time, big record vs obj"
./create_big_noise.native
./create_big_rec.native
./create_big_obj.native
echo "\nupdate time, record vs obj, small"
./update_small_noise.native
./update_small_rec.native
./update_small_obj.native
echo "\nupdate time, record vs obj, big"
./update_big_noise.native
./update_big_rec.native
./update_big_obj.native

rm *.cmi
rm *.cmx
rm *.o
rm *.native
