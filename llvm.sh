#! /bin/sh
set -eo nounset

T=`mktemp XXXXXXXX`
trap "test -f $T && mv $T $T.exe ; rm -f $T.bc" 0

while : ; do
	polygen llvm.grm > $T.bc
	clang -o $T $T.bc \
		2> /dev/null || \
	clang -shared -undefined dynamic_lookup -o lib$T.so $T.bc \
		2> /dev/null || \
	continue
	break
done

if [ -f $T ] ; then
	mv $T $T.exe
	gpg --detach-sig $T.exe
fi

gpg --detach-sig lib$T.so
