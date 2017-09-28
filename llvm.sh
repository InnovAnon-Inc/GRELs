#! /bin/sh
set -exo nounset

T=`mktemp XXXXXXXX`
trap "test -f $T && mv $T $T.exe ; rm -f $T.bc" 0

while : ; do
	polygen llvm.grm > $T.bc
	clang -o $T $T.bc || \
	clang -shared -undefined dynamic_lookup -o lib$T.so $T.bc || \
	continue
	break
done
