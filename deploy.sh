cp hash_LB.conf $SDE_INSTALL/share/p4/targets/
cd $SDE/pkgsrc/p4-build-4.1.1.15
./configure --prefix=$SDE_INSTALL --with-tofino P4_NAME=hash_LB P4_PATH=~/hash_LB/hash_LB.p4 --enable-thrift
make -j4
make install