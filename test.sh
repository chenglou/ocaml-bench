corebuild -pkg core_bench access_small.native &&
corebuild -pkg core_bench access_big.native &&
corebuild -pkg core_bench access_mutHeapValue.native &&
corebuild -pkg core_bench access_obj_small_cache.native &&
corebuild -pkg core_bench access_obj_big_cache.native &&
corebuild -pkg core_bench access_obj_openclosed.native &&
corebuild -pkg core_bench create_small.native &&
corebuild -pkg core_bench create_big.native &&
corebuild -pkg core_bench update_small.native &&
corebuild -pkg core_bench update_big.native &&

./access_small.native &&
./access_big.native &&
./access_mutHeapValue.native &&
./access_obj_small_cache.native &&
./access_obj_big_cache.native &&
./access_obj_openclosed.native &&
./create_small.native &&
./create_big.native &&
./update_small.native &&
./update_big.native &&

rm *.native
