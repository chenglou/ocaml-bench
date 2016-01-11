ocamlopt accessNoiseSmall.ml -o accessNoiseSmall.native
ocamlopt accessRecSmall.ml -o accessRecSmall.native
ocamlopt accessObjSmall.ml -o accessObjSmall.native

ocamlopt accessNoiseBig.ml -o accessNoiseBig.native
ocamlopt accessRecBig.ml -o accessRecBig.native
ocamlopt accessObjBig.ml -o accessObjBig.native

ocamlopt mutHeapValueAccessNoise.ml -o mutHeapValueAccessNoise.native
ocamlopt mutHeapValueAccessRec.ml -o mutHeapValueAccessRec.native
ocamlopt mutHeapValueAccessObj.ml.ml -o mutHeapValueAccessObj.native

ocamlopt accessNoiseCachedSmall.ml -o accessNoiseCachedSmall.native
ocamlopt accessObjCachedSmall.ml -o accessObjCachedSmall.native
ocamlopt accessObjNonCachedSmall.ml -o accessObjNonCachedSmall.native

ocamlopt accessNoiseCachedBig.ml -o accessNoiseCachedBig.native
ocamlopt accessObjCachedBig.ml -o accessObjCachedBig.native
ocamlopt accessObjNonCachedBig.ml -o accessObjNonCachedBig.native

ocamlopt accessNoiseOpen.ml -o accessNoiseOpen.native
ocamlopt accessObjOpen.ml -o accessObjOpen.native
ocamlopt accessObjClosed.ml -o accessObjClosed.native

ocamlopt createNoiseSmall.ml -o createNoiseSmall.native
ocamlopt createRecSmall.ml -o createRecSmall.native
ocamlopt createObjSmall.ml -o createObjSmall.native

ocamlopt createNoiseBig.ml -o createNoiseBig.native
ocamlopt createRecBig.ml -o createRecBig.native
ocamlopt createObjBig.ml -o createObjBig.native

ocamlopt updateNoiseSmall.ml -o updateNoiseSmall.native
ocamlopt updateRecSmall.ml -o updateRecSmall.native
ocamlopt updateObjSmall.ml -o updateObjSmall.native

ocamlopt updateNoiseBig.ml -o updateNoiseBig.native
ocamlopt updateRecBig.ml -o updateRecBig.native
ocamlopt updateObjBig.ml -o updateObjBig.native

echo "=========start benchmarks========="

echo "\naccess time, small record vs obj (cached)"
./accessNoiseSmall.native
./accessRecSmall.native
./accessObjSmall.native
echo "\naccess time, big record vs obj (cached)"
./accessNoiseBig.native
./accessRecBig.native
./accessObjBig.native
echo "\naccess time with mutable + heap allocated value, record vs obj (cached)"
./mutHeapValueAccessNoise.native
./mutHeapValueAccessRec.native
./mutHeapValueAccessObj.native
echo "\naccess time, obj cached vs uncached, small"
./accessNoiseCachedSmall.native
./accessObjCachedSmall.native
./accessObjNonCachedSmall.native
echo "\naccess time, obj cached vs uncached, big"
./accessNoiseCachedBig.native
./accessObjCachedBig.native
./accessObjNonCachedBig.native
echo "\naccess time, open vs closed obj"
./accessNoiseOpen.native
./accessObjOpen.native
./accessObjClosed.native
echo "\ncreation time, small record vs obj"
./createNoiseSmall.native
./createRecSmall.native
./createObjSmall.native
echo "\ncreation time, big record vs obj"
./createNoiseBig.native
./createRecBig.native
./createObjBig.native
echo "\nupdate time, record vs obj, small"
./updateNoiseSmall.native
./updateRecSmall.native
./updateObjSmall.native
echo "\nupdate time, record vs obj, big"
./updateNoiseBig.native
./updateRecBig.native
./updateObjBig.native

rm *.cmi
rm *.cmx
rm *.o
rm *.native
