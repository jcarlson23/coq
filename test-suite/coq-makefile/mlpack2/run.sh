#!/usr/bin/env bash

#set -x
set -e

. ../template/init.sh

coq_makefile -f _CoqProject -o Makefile
make
make html mlihtml
make install DSTROOT="$PWD/tmp"
#make debug
(cd `find tmp -name user-contrib`; find .) | sort > actual
sort > desired <<EOT
.
./test
./test/test.glob
./test/test_plugin.cmi
./test/test_plugin.cmx
./test/test_plugin.cmxs
./test/test.v
./test/test.vo
EOT
exec diff -u desired actual
