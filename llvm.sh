#! /bin/sh
set -exo nounset

T=`mktemp XXXXXXXX.bc`
trap "rm -f $T" 0

while : ; do
	polygen llvm.grm > $T
	#clang -o llvm $T || continue
	clang -shared -undefined dynamic_lookup -o libllvm.so $T || continue
	break
done
