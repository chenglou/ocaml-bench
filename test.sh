ocamlopt accessObjSmall.ml -o accessObjSmall.native
ocamlopt accessObjBig.ml -o accessObjBig.native
ocamlopt accessObjClosed.ml -o accessObjClosed.native
ocamlopt accessObjCachedSmall.ml -o accessObjCachedSmall.native
ocamlopt accessObjNonCachedSmall.ml -o accessObjNonCachedSmall.native
ocamlopt accessObjCachedBig.ml -o accessObjCachedBig.native
ocamlopt accessObjNonCachedBig.ml -o accessObjNonCachedBig.native
ocamlopt accessObjOpen.ml -o accessObjOpen.native
ocamlopt accessRecSmall.ml -o accessRecSmall.native
ocamlopt accessRecBig.ml -o accessRecBig.native
ocamlopt createObjBig.ml -o createObjBig.native
ocamlopt createObjSmall.ml -o createObjSmall.native
ocamlopt createRecBig.ml -o createRecBig.native
ocamlopt createRecSmall.ml -o createRecSmall.native
ocamlopt mutHeapValueAccessObj.ml.ml -o mutHeapValueAccessObj.native
ocamlopt mutHeapValueAccessRec.ml -o mutHeapValueAccessRec.native
ocamlopt updateObjBig.ml -o updateObjBig.native
ocamlopt updateObjSmall.ml -o updateObjSmall.native
ocamlopt updateRecBig.ml -o updateRecBig.native
ocamlopt updateRecSmall.ml -o updateRecSmall.native

echo "=========start benchmarks========="

echo "\naccess time, small record vs obj (cached)"
./accessRecSmall.native
./accessObjSmall.native
echo "\naccess time, big record vs obj (cached)"
./accessRecBig.native
./accessObjBig.native
echo "\naccess time with mutable + heap allocated value, record vs obj (cached)"
./mutHeapValueAccessRec.native
./mutHeapValueAccessObj.native
echo "\naccess time, obj cached vs uncached, small"
./accessObjCachedSmall.native
./accessObjNonCachedSmall.native
echo "\naccess time, obj cached vs uncached, big"
./accessObjCachedBig.native
./accessObjNonCachedBig.native
echo "\naccess time, open vs closed obj"
./accessObjOpen.native
./accessObjClosed.native
echo "\ncreation time, small record vs obj"
./createRecSmall.native
./createObjSmall.native
echo "\ncreation time, big record vs obj"
./createRecBig.native
./createObjBig.native
echo "\nupdate time, record vs obj, small"
./updateRecSmall.native
./updateObjSmall.native
echo "\nupdate time, record vs obj, big"
./updateRecBig.native
./updateObjBig.native

rm *.cmi
rm *.cmx
rm *.o
rm *.native
